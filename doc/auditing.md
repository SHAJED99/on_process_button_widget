# Auditing this package — a guide for AI agents

This document tells an AI agent how to audit `on_process_button_widget` for **real bugs**, not lint nitpicks. It exists because two separate audits of this codebase found bugs that a normal "read the diff and comment" review would have missed entirely — every one of them was found by applying a specific, repeatable check, and confirmed by running code rather than by reading it.

Claude Code users also have this as an auto-triggering skill at `.claude/skills/audit-resolution-chain/SKILL.md` (same method, slightly terser). Other agents should read this file. If you were told to "audit the package," "check the resolution chain," or you're about to cut a release, you're in the right place.

## How to use this document

Work through the checks in order and treat each one as a hypothesis to disprove, not a box to tick. Concretely:

1. Establish a baseline (below) so you know what breakage you inherited vs. caused.
2. Read all of `lib/` in full — see "Read first, grep second."
3. Run each of the seven checks in "Bug patterns with a track record."
4. For anything behavioral, **prove it with a throwaway test** — see "Verify by running, not reading."
5. Report findings as a table and **stop**. Don't fix yet.
6. Fix only what the user approves, following "If you're asked to fix."

The single most important habit: this codebase's bugs are mostly *silent*. Nothing crashes, the analyzer stays green, and the tests pass. A property just quietly does nothing, or reports a value that isn't true. So "it analyzes clean and the tests pass" is the starting point of an audit, not the conclusion.

## Baseline

This repo pins Flutter via FVM (`.fvmrc`), so prefix commands with `fvm` unless your global Flutter already matches:

```bash
fvm flutter pub get
fvm flutter analyze          # strict-casts + strict-inference are on
fvm flutter test
cd example && fvm flutter analyze   # the example has its own pubspec; root analyze skips it
```

Read the `info`-level analyzer output too, not just errors — but treat lints as a cleanup pass, never as the audit's findings.

## Read first, grep second

`lib/on_process_button_widget.dart` plus the four `part of` files under `lib/src/` are the whole library (~1500 lines). Read them end to end before touching anything.

Grep is how you *check* a hypothesis; it is not how you *form* one. The highest-value bug found here — a resolved value that was computed and then silently thrown away — is invisible to grep, because nothing is misspelled and nothing is missing. You only notice it by reading the resolution code and the consuming code together and asking "…is this value ever actually used?"

## The invariant that matters most

Every user-facing property resolves through a 3-tier chain and is stored in a state field:

```
widget.<prop> ?? OnProcessButtonTheme.of(context)?.<prop> ?? OnProcessButtonDefaultValues.<prop> ?? hardcoded
```

Resolution happens in `____setValues()` (context-independent fallbacks) and `___setNotFinalVariables()` (fallbacks that need `Theme.of(context)`). Everything downstream — `build()`, `boxDecoration()`, the underscore getters — must consume the **resolved field**, never `widget.<prop>` again. Adding a property means touching four places in lockstep; `CLAUDE.md` lists them.

## Bug patterns with a track record

Each of these has produced at least one real, confirmed bug in this package. They're ordered by how much they've paid off.

### 1. Resolution-chain bypass

A property is correctly resolved into a state field, but the consuming code reads `widget.<prop>` directly — so theme and global-default values for that property are silently ignored. *Found once: `constraints`, bypassed in two places (a getter and `build()`), meaning `OnProcessButtonThemeData(constraints: …)` did nothing at all.*

To check:
- List every field assigned in `____setValues` / `___setNotFinalVariables`. Those are the resolved fields.
- Grep `widget\.\w+` inside `_OnProcessButtonWidgetState` *below* the resolution methods.
- Any hit that names a resolved field is a suspect. (`widget.isRunning` and `widget.child` are legitimate — they're deliberately outside the chain.)
- From the other direction: for each resolved field, grep the file for the bare field name. If it's only ever written and never read, that's the same bug.

### 2. Instance state that should be local

State that only makes sense within one invocation, stored as an instance field, leaks between invocations. *Found once: `result` was a field on the state, so tapping a button whose resolved `onTap` was `null` fired `onDone(true)` — the previous tap's value — for an operation that never ran.*

To check: for each field on `_OnProcessButtonWidgetState`, ask whether anything outside a single tap-handler run reads it. If not, it should be a local. As a bonus, making it local usually lets Dart type-promote it and removes `!` assertions.

### 3. Constructor ↔ `copyWith` type drift

`OnProcessButtonThemeData` declares each property twice — once as a field, once as a `copyWith` parameter — by hand. They drift, and the analyzer won't notice because both spellings are individually valid. *Found once: `copyWith`'s `onTap` was `Future<bool?> Function()?` while the field was `Future<bool?>? Function()?`, so `copyWith` rejected callbacks the constructor accepted.*

To check: diff the two type lists property by property. Watch nullability on function-typed properties especially — the `?` that differs is easy to skim past.

### 4. Defaults that diverge from Flutter's norms

A hardcoded fallback that's surprising is a bug even when it's "documented." *Found once: `autofocus` defaulted to `true` (Flutter's own buttons default to `false`), so every button silently requested focus — measurably stealing it from an autofocused `TextField` in the same scope, which breaks forms.*

To check: read the hardcoded fallbacks at the end of each resolution line in `____setValues` and compare against the equivalent Flutter widget's default. Anything that differs needs a reason.

### 5. Incomplete gating

A flag that implies a broad behavior but only gates part of it. *Found once: `enable: false` nulled `onTap` but left `onLongPress`, `onDoubleTap`, tap up/down/cancel, and all the secondary-tap callbacks live — a "disabled" button that still fired callbacks.*

To check: for each boolean that gates behavior, enumerate everything a user would reasonably expect it to cover, then confirm each one is actually gated.

### 6. Unit and dimension errors in layout math

Mixing unitless multipliers with logical pixels. *Found once: `____contentHeight` ran `TextStyle.height` — a multiple of the font size — through `TextScaler` and subtracted it from the font size, which is dimensionally meaningless.*

To check: for each arithmetic expression mixing values from different sources, name the unit of each operand. `TextStyle.height` is a multiplier; `fontSize` is logical pixels; `textScaler.scale()` expects pixels. Note this one was largely masked by a downstream clamp — report impact honestly rather than overselling.

### 7. Doc-vs-code drift

`CLAUDE.md`, `AGENTS.md`, and `README.md` are hand-maintained and describe behavior in specific detail, including line numbers. Treat every claim as a hypothesis. *Found twice: `AGENTS.md` described `onTap`-throw handling the code didn't implement, and `CLAUDE.md` made the same claim — both were aspirational until the behavior was actually built.*

A doc describing behavior the code doesn't have is a finding in its own right. Decide which side is wrong — sometimes the doc is the correct spec and the code is the bug.

### Also worth a look

- **Shared mutable objects in global defaults.** `OnProcessButtonDefaultValues` is process-global. Immutable values and widgets are fine to share; stateful objects are not. A `FocusNode` set there is shared by every button in the app and breaks once two are mounted.
- **Async gaps.** The tap handler `await`s twice. Check `mounted` before `setState`, and remember that resolved fields can be reassigned mid-flight by a rebuild.

## Verify by running, not reading

If your finding is about runtime behavior, prove it. Write a small widget test under `test/`, run it, and **delete it** once it's told you what you need — scratch tests don't belong in the tree, and shouldn't join the permanent suite until an actual fix lands.

Two traps that have already burned an audit here:

**A `Scaffold` body imposes tight constraints.** `tester.getSize()` on a widget inside one reports the full screen size no matter what your `BoxConstraints` are doing, so it will happily confirm a bug that isn't there and hide one that is. Inspect the widget's own property instead:

```dart
tester.widgetList<Container>(find.byType(Container)).map((w) => w.constraints)
```

**Uncaught async errors fail the test outright.** The `InkWell.onTap` handler is a `void Function()` wrapping an `async` body, so anything it throws becomes a Zone-level uncaught error. `tester.takeException()` will *not* catch it — that only surfaces errors reported through `FlutterError`. Wrap the interaction in `runZonedGuarded` and collect from its handler:

```dart
final caught = <Object>[];
await runZonedGuarded(() async {
  await tester.pumpWidget(...);
  await tester.tap(find.text('Tap Me'));
  await tester.pump();
}, (Object error, StackTrace stack) => caught.add(error));
expect(caught, hasLength(1));
```

Also note: `OnProcessButtonDefaultValues` is global with no `reset()`. Any test that sets it leaks into later tests in the same run — clear it in `tearDown`.

## Report before fixing

Produce a table with, for each finding: file and line, a one-line summary, and the **concrete failure you actually confirmed** (inputs/state → wrong output). Rank by confidence and impact together. Say plainly when something is real but low-impact — an audit that oversells its findings is worse than one that misses a few, because the next person stops trusting it.

Then stop and let the user choose what to fix.

## If you're asked to fix

- Add a permanent regression test per confirmed bug, using the `runZonedGuarded` pattern above for async-exception paths.
- Re-run `fvm flutter analyze` and `fvm flutter test` (plus `example/`'s analyze) — all clean before you report back.
- Update the docs that state the old behavior. A default change touches `README.md`'s property tables, `AGENTS.md`'s tables, and often `CLAUDE.md`.
- **Don't cut a release unless asked.** Per this repo's convention, `pubspec.yaml` version, `CHANGELOG.md`, and `README.md` (including the version badge and install snippet) move together. If a fix changes runtime behavior or a default, it needs at least a minor bump, not a patch — and the CHANGELOG entry should say how to restore the old behavior.
