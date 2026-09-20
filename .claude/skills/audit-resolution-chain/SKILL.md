---
name: audit-resolution-chain
description: Audits this repo (on_process_button_widget) for real, previously-undetected bugs — not lint nitpicks. Covers the 3-tier property resolution chain (widget → theme → defaults → hardcoded), constructor/copyWith type symmetry, and doc-vs-code drift in CLAUDE.md/AGENTS.md/README/CHANGELOG. Use this whenever the user asks to "audit" the package, "audit for bugs," "check the resolution chain," "review this widget for correctness," or before cutting a release. Prefer this over a generic code review here — it encodes bug patterns already found once in this codebase that are easy to reintroduce during a refactor.
---

# Auditing on_process_button_widget

This package has one invariant that matters more than anything else (see `CLAUDE.md`): every user-facing property must resolve as

```
widget.<prop> ?? OnProcessButtonTheme.of(context)?.<prop> ?? OnProcessButtonDefaultValues.<prop> ?? hardcoded
```

Most real bugs in this codebase are violations of that chain, or of the analogous symmetry between `OnProcessButtonThemeData`'s constructor and its `copyWith`. Lint-level issues (formatting, `use_super_parameters`, etc.) are worth a quick pass but are not the point of this skill — don't let them crowd out the checks below, and don't report a finding unless you'd bet on it being real.

## Before you start: baseline

Run this repo's actual toolchain, not assumptions about it:

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
```

(`fvm` because this repo pins a specific Flutter version — see `.fvmrc`.) Note the current pass/fail state so you know what you introduced vs. what was already there. `flutter analyze` is checked with strict-casts/strict-inference; read its `info`-level output too, not just errors — but treat those as a minor cleanup pass, not the audit's main output.

## Step 1 — Read the source in full, then check docs against it

`lib/on_process_button_widget.dart` plus the four `part of` files under `lib/src/` are the entire library (~1500 lines total). Read them in full — not via grep — before touching anything else. Grepping finds keywords; it won't show you that a resolved field is computed and then never read, which is exactly the shape of the most valuable bugs here.

While reading, treat every specific claim in `CLAUDE.md` and `AGENTS.md` (line numbers, method names, described behavior) as a hypothesis to verify against the current source, not a fact. These files are hand-maintained and drift after refactors — a docs file describing behavior the code no longer has is itself a finding worth reporting (and fixing, if you're asked to fix).

## Step 2 — Hunt for resolution-chain bypasses (highest-value check)

This is the check that found the `constraints` bug: a property was correctly resolved into a state field (with theme and defaults fallback) inside `____setValues`/`___setNotFinalVariables`, but the actual `build()`/getter code kept reading `widget.<prop>` directly, so the resolved field was computed and silently discarded.

To repeat this check after any change to `lib/src/on_process_button_widget.dart`:

1. In the state resolution methods (`____setValues`, `___setNotFinalVariables`), list every field being assigned — these are the "resolved" fields.
2. `grep -n "widget\.\w+"` inside `_OnProcessButtonWidgetState` (everything below the resolution methods: `build()`, `boxDecoration()`, and the underscore getters).
3. For each match, ask: is this one of the resolved fields from step 1? If so, it should almost never be read as `widget.<prop>` outside the resolution method itself — reading `widget.<prop>` there means theme/defaults values for that property are being ignored. (`widget.isRunning` and `widget.child` are legitimate exceptions — they aren't part of the resolution chain by design.)
4. Any resolved field that step 1 computes but that a `grep -n "\b<fieldName>\b"` across the file shows is never read anywhere outside its own assignment is a strong signal of the same bug, just from the other direction.

## Step 3 — Constructor vs. `copyWith` type symmetry

`OnProcessButtonThemeData` (and `OnProcessButtonWidget`) declare the same properties in more than one place: the constructor/field declarations, and `copyWith`'s parameter list. These are hand-written, not generated, so they can drift — `copyWith`'s `onTap` parameter was once typed narrower than the constructor's, silently rejecting values the constructor accepted.

To check: for each property, diff the type as declared on the field vs. as declared in `copyWith`'s parameter list. They should be identical. Pay particular attention to nullable return types on function-typed properties (`Future<bool?>? Function()?` vs. `Future<bool?> Function()?`) — the difference is easy to miss and the analyzer won't flag it since both are individually valid.

## Step 4 — Don't trust static reading for behavioral claims

If you form a hypothesis about runtime behavior (state machine transitions, what happens on an exception, whether a value reaches the render tree), verify it empirically before reporting it as a finding. Write a small throwaway widget test under `test/`, run it, and delete it once you've confirmed or refuted the hypothesis — don't leave scratch tests in the tree, and don't fold them into the permanent suite until a fix is actually being made.

Two traps worth knowing about, both hit during the original audit of this package:

- **A `Scaffold` body gives tight layout constraints**, so `tester.getSize()` on a `Container` inside one will often report the full screen size regardless of any `BoxConstraints` bug — it won't tell you what you think it tells you. To check whether a resolved constraint actually reached a widget, inspect the widget's own field instead of the rendered size, e.g.:
  ```dart
  tester.widgetList<Container>(find.byType(Container)).map((w) => w.constraints)
  ```
- **An uncaught exception thrown from inside a fire-and-forget async callback** (e.g. the `InkWell.onTap` handler here, which is `void Function()` wrapping an `async` body) becomes a Zone-level uncaught error. Flutter's test framework fails the test immediately if this happens inside a plain `testWidgets` body — `tester.takeException()` will *not* catch it, because that only surfaces errors reported through `FlutterError`, not raw uncaught async errors. To test this kind of path (e.g. confirming an error is deliberately caught, state is reset, and then rethrown), wrap the pump/tap sequence in `runZonedGuarded` and collect errors via its `onError` callback instead:
  ```dart
  final caught = <Object>[];
  await runZonedGuarded(() async {
    await tester.pumpWidget(...);
    await tester.tap(...);
    await tester.pump();
  }, (Object error, StackTrace stack) => caught.add(error));
  expect(caught, hasLength(1)); // confirms it surfaced, not swallowed
  ```

## Step 5 — Docs and release-metadata consistency (lower priority)

Quick pass, not the main event:

- `pubspec.yaml`'s `version` matches the newest `## x.y.z` heading in `CHANGELOG.md`.
- README's property tables and prose match the actual defaults/types in `OnProcessButtonDefaultValues` and the widget constructor — this file gets rewritten periodically and can drift from the code between rewrites.
- `AGENTS.md`'s property reference table is exhaustive — if you added/renamed/removed a property, this table needs the matching row, and so does `CLAUDE.md`'s "touching four places in lockstep" list.

## Step 6 — Report before fixing

Give the user a table: file/line, one-line summary, and the concrete failure scenario you actually confirmed (input/state → wrong behavior), not just "this looks off." Rank by how certain and how impactful each finding is. Wait for the user to say go before changing any code — they may only want the report, or may want to fix a subset.

## Step 7 — If asked to fix

- Add a permanent regression test for each confirmed bug (using the `runZonedGuarded` pattern above for async-exception cases) so it can't silently reappear.
- Re-run `fvm flutter analyze` and `fvm flutter test` after fixing — both should be clean before you report back.
- Don't bump `pubspec.yaml`'s version or touch `CHANGELOG.md`/README unless the user explicitly wants a release cut — fixing code and shipping a release are different requests here, per this repo's convention of updating version + CHANGELOG + README together only at release time.
