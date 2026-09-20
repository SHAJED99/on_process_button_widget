import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

void main() {
  testWidgets('OnProcessButtonWidget displays child text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnProcessButtonWidget(
            onTap: () async => true,
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    expect(find.text('Tap Me'), findsOneWidget);
  });

  testWidgets('OnProcessButtonWidget shows loading indicator on tap',
      (WidgetTester tester) async {
    bool tapCompleted = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnProcessButtonWidget(
            statusShowingDuration: const Duration(milliseconds: 100),
            onTap: () async {
              await Future<void>.delayed(const Duration(milliseconds: 100));
              tapCompleted = true;
              return true;
            },
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pump(); // Start animation

    // Should show CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 150));
    expect(tapCompleted, true);

    // Settle the rest of the timers (statusShowingDuration and reset)
    await tester.pumpAndSettle();
  });

  testWidgets('OnProcessButtonWidget shows success icon after successful tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnProcessButtonWidget(
            onTap: () async => true,
            statusShowingDuration: const Duration(milliseconds: 100),
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pump(); // Start loading
    await tester.pump(); // Loading completes, show success

    expect(find.byIcon(Icons.done), findsOneWidget);

    // Settle statusShowingDuration and reset to stable
    await tester.pumpAndSettle();
    });

  testWidgets('OnProcessButtonWidget shows error icon after failed tap',
      (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnProcessButtonWidget(
            onTap: () async => false,
            statusShowingDuration: const Duration(milliseconds: 100),
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pump(); // Start loading
    await tester.pump(); // Loading completes, show error

    expect(find.byIcon(Icons.error), findsOneWidget);

    // Settle statusShowingDuration and reset to stable
    await tester.pumpAndSettle();
  });

  testWidgets('OnProcessButtonWidget recovers to stable when onTap throws',
      (WidgetTester tester) async {
    final caught = <Object>[];

    await runZonedGuarded(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: OnProcessButtonWidget(
                onTap: () async => throw Exception('boom'),
                child: const Text('Tap Me'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Tap Me'));
        await tester.pump();
      },
      (Object error, StackTrace stack) => caught.add(error),
    );

    // The original error is rethrown, not silently swallowed.
    expect(caught, hasLength(1));
    expect(caught.single, isException);

    // But the button still recovers to stable instead of getting stuck.
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Tap Me'), findsOneWidget);
  });

  testWidgets('OnProcessButtonWidget honors constraints from theme data',
      (WidgetTester tester) async {
    const bigConstraints = BoxConstraints(minHeight: 300, minWidth: 300);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnProcessButtonThemeProvider(
            data: const OnProcessButtonThemeData(constraints: bigConstraints),
            child: OnProcessButtonWidget(
              onTap: () async => true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      ),
    );

    final constraints = tester
        .widgetList<Container>(find.byType(Container))
        .map((w) => w.constraints)
        .whereType<BoxConstraints>();
    expect(
      constraints.any((c) => c.minHeight >= 300 && c.minWidth >= 300),
      isTrue,
    );
  });

  testWidgets('OnProcessButtonWidget does not autofocus by default',
      (WidgetTester tester) async {
    final fieldFocus = FocusNode();
    addTearDown(fieldFocus.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              TextField(focusNode: fieldFocus, autofocus: true),
              OnProcessButtonWidget(
                onTap: () async => true,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    // The button must not steal focus from an autofocused field.
    expect(fieldFocus.hasFocus, isTrue);
  });

  testWidgets('OnProcessButtonWidget reports null to onDone when onTap is null',
      (WidgetTester tester) async {
    final doneValues = <bool?>[];

    Widget build({required bool withOnTap}) {
      return MaterialApp(
        home: Scaffold(
          body: OnProcessButtonWidget(
            statusShowingDuration: const Duration(milliseconds: 10),
            onTap: withOnTap ? () async => true : null,
            onDone: doneValues.add,
            child: const Text('Tap Me'),
          ),
        ),
      );
    }

    await tester.pumpWidget(build(withOnTap: true));
    await tester.tap(find.text('Tap Me'));
    await tester.pumpAndSettle();

    await tester.pumpWidget(build(withOnTap: false));
    await tester.tap(find.text('Tap Me'));
    await tester.pumpAndSettle();

    // The second tap ran no operation, so it must not report the stale `true`.
    expect(doneValues, <bool?>[true, null]);
  });
}
