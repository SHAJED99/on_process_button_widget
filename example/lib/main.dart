import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RxString buttonText = "Hover Here".obs;
  final RxString processDone = "".obs;
  final RxBool buttonRunning = true.obs;

  Future<bool?> onCallFunction({bool? type}) async {
    await Future.delayed(const Duration(seconds: 2));
    return type;
  }

  final Widget _____spacing = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        buttonTheme: const ButtonThemeData(height: 100),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //! Hovering effect && On processing loading indicator
                    OnProcessButtonWidget(
                      backgroundColor: const Color(0XFF86A789),
                      onTap: () async => await onCallFunction(),
                      onHover: (isEnter) => buttonText.value = isEnter
                          ? "Hi"
                          : "Hover Here - Only works in Mouse hovering.",
                      child: Text(buttonText.value),
                    ),
                    _____spacing,

                    //! Request status - true and false
                    OnProcessButtonWidget(
                      backgroundColor: const Color(0XFF739072),
                      onTap: () async => await onCallFunction(type: true),
                      // onTap: () async => await onCallFunction(type: false),
                      child: const Text("Request status - true"),
                    ),
                    _____spacing,

                    OnProcessButtonWidget(
                      backgroundColor: const Color(0XFF739072),
                      onTap: () async => await onCallFunction(type: false),
                      // onTap: () async => await onCallFunction(type: false),
                      child: const Text("Request status - false"),
                    ),
                    _____spacing,

                    //! Double process
                    OnProcessButtonWidget(
                      backgroundColor: const Color(0XFF4F6F52),
                      onTap: () async {
                        processDone.value = "Running first task.";
                        var s = await onCallFunction(type: true);
                        processDone.value = "First operation status $s";
                        return s;
                      },
                      onDone: (isSuccess) async {
                        // TODO: You can your homepage here. If onTap function (Login process) return true it will redirect to the homepage.
                        processDone.value = "Running second task.";
                        await onCallFunction();
                        processDone.value = "";
                      },
                      child: const Text("Double process"),
                    ),
                    if (processDone.isNotEmpty)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text("Process status: ${processDone.value}")),
                    _____spacing,

                    //! Shadow and Icon color can be changed
                    OnProcessButtonWidget(
                      iconColor: Colors.white,
                      backgroundColor: const Color(0XFF3A4D39),
                      onTap: () async => await onCallFunction(type: false),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black54,
                            blurRadius: 2)
                      ],
                      child:
                          const Text("My shadow and Icon color can be changed"),
                    ),
                    _____spacing,

                    //! On processing widget is changeable
                    OnProcessButtonWidget(
                      backgroundColor: const Color(0XFFFAE7C9),
                      onTap: () async => await onCallFunction(type: true),
                      onRunningWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "On processing widget is changed",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      onSuccessWidget: const Icon(
                        Icons.wallpaper_rounded,
                        color: Colors.black,
                      ),
                      child: const Text(
                        "On processing and Status widget",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _____spacing,

                    //! Use as a card
                    const OnProcessButtonWidget(
                      enable: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 24),
                      backgroundColor: Color.fromARGB(255, 242, 242, 242),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black54,
                            blurRadius: 2)
                      ],
                      child: Text(
                        "I am a Button,\nBut I can be used as a card.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _____spacing,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
