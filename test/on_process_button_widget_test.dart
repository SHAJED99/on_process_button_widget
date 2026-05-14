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
}
