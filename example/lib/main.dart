import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

void main() {
  OnProcessButtonDefaultValues.expandedIcon = true;
  OnProcessButtonDefaultValues.roundBorderWhenRunning = false;
  OnProcessButtonDefaultValues.onStatusChange = (context, status) {
    if (context == null) return;
    if (status == OnProcessButtonStatus.running) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AlertDialog(
          title: Text('Processing'),
          content: Text('Please wait...'),
        ),
      );
    } else if (status == OnProcessButtonStatus.stable) {
      Navigator.of(context).pop();
    }
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  String buttonText = 'Hover Here';
  String processStatus = '';

  Future<bool?> simulateAsync({bool? result, int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = const SizedBox(height: 12);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 1) Basic filled button with hover callback
              OnProcessButtonWidget(
                expanded: false,
                backgroundColor: const Color(0xFF86A789),
                onHover: (isEnter) {
                  setState(() {
                    buttonText = isEnter ? 'Hello!' : 'Hover Here';
                  });
                },
                onTap: () async => await simulateAsync(),
                child: Text(buttonText),
              ),
              spacing,

              // 2) Show success icon
              OnProcessButtonWidget(
                backgroundColor: const Color(0xFF739072),
                onTap: () async => await simulateAsync(result: true),
                child: const Text('Return true → Success'),
              ),
              spacing,

              // 3) Show error icon
              OnProcessButtonWidget(
                backgroundColor: const Color(0xFF739072),
                onTap: () async => await simulateAsync(result: false),
                child: const Text('Return false → Error'),
              ),
              spacing,

              // 4) Double process — chain via onDone
              OnProcessButtonWidget(
                backgroundColor:
                    const Color(0xFF4F6F52).withValues(alpha: 0.5),
                onTap: () async {
                  setState(() => processStatus = 'Running first task...');
                  final success = await simulateAsync(result: true);
                  setState(
                      () => processStatus = 'First result: $success');
                  return success;
                },
                onDone: (isSuccess) {
                  setState(() => processStatus = 'Running second task...');
                },
                child: const Text('Double Process (onDone)'),
              ),
              if (processStatus.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(processStatus,
                      style: const TextStyle(fontSize: 12)),
                ),
              spacing,

              // 5) Shadow and custom icon color
              OnProcessButtonWidget(
                iconColor: Colors.white,
                backgroundColor: const Color(0xFF3A4D39),
                onTap: () async => await simulateAsync(result: false),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black54,
                    blurRadius: 2,
                  ),
                ],
                child: const Text('Shadow + Icon Color'),
              ),
              spacing,

              // 6) Custom running/success/error widgets
              OnProcessButtonWidget(
                backgroundColor: const Color(0xFFFAE7C9),
                fontColor: Colors.black,
                iconColor: Colors.black,
                onTap: () async => await simulateAsync(result: true),
                onRunningWidget: const Text('Loading...',
                    style: TextStyle(color: Colors.black)),
                onSuccessWidget: const Icon(Icons.wallpaper_rounded,
                    color: Colors.black),
                onErrorWidget: const Icon(Icons.warning_rounded,
                    color: Colors.black),
                child: const Text('Custom Status Widgets'),
              ),
              spacing,

              // 7) Button as a card (disabled, no onTap)
              const OnProcessButtonWidget(
                enable: false,
                contentPadding: EdgeInsets.symmetric(vertical: 24),
                backgroundColor: Color(0xFFF2F2F2),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black54,
                    blurRadius: 2,
                  ),
                ],
                child: Text(
                  'I am a Button,\nBut I can be used as a Card.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              spacing,

              // 8) Compact icon button (returns null to skip status)
              OnProcessButtonWidget(
                height: 24,
                width: 36,
                borderRadius: BorderRadius.circular(6),
                constraints: const BoxConstraints(),
                contentPadding: const EdgeInsets.all(4),
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  return null;
                },
                child: const FittedBox(
                  child: Icon(Icons.done, color: Colors.white),
                ),
              ),
              spacing,

              // 9) Outlined button with border
              OnProcessButtonWidget(
                expanded: false,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: Colors.red,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                backgroundColor: Colors.transparent,
                iconColor: Colors.red,
                fontColor: Colors.red,
                fontWeight: FontWeight.normal,
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  return true;
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete_outline, size: 18),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
