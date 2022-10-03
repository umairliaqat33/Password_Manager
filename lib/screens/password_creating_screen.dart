import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/providers/password_generator_state_notifier.dart';

class PasswordCreation extends ConsumerStatefulWidget {
  const PasswordCreation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordCreationState();
}

class _PasswordCreationState extends ConsumerState<PasswordCreation> {
  late TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(paswordStateNotifierProvider);
    textController.text = ref.read(passwordGenratorProvider);
  }

  @override
  Widget build(BuildContext context) {
    final password = ref.watch(passwordGenratorProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text(
                      "Your Password",
                      style: TextStyle(color: Colors.purple),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  enabled: false,
                  controller: textController,
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: false,
                child: Text(
                  "Please generate password first",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(passwordGenratorProvider);
                      textController.text = password;
                      log('message');
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.purple),
                    ),
                    child: Text("Generate"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      if (!textController.text.isEmpty) {
                        Clipboard.setData(
                            ClipboardData(text: textController.text));
                        Fluttertoast.showToast(msg: "Text Copied");
                      } else {}
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.purple),
                    ),
                    child: Text("Copy"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Select checkbox to generate password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.purple),
              ),
              Visibility(
                visible: false,
                child: Text(
                  "Please make a selection of text in password",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value:
                        ref.watch(paswordStateNotifierProvider).enableUpperCase,
                    onChanged: (v) {
                      ref
                          .read(paswordStateNotifierProvider.notifier)
                          .toggleUpperCase();
                      textController.text = password;
                    },
                  ),
                  Text(
                    "Alphabets",
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value:
                        ref.watch(paswordStateNotifierProvider).enableSymbols,
                    onChanged: (v) {
                      ref
                          .read(paswordStateNotifierProvider.notifier)
                          .toggleSymbols();
                      textController.text = password;
                    },
                  ),
                  Text(
                    "Special Characters",
                    style: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: ref.watch(paswordStateNotifierProvider).enableDigits,
                    onChanged: (v) {
                      ref
                          .read(paswordStateNotifierProvider.notifier)
                          .toggleDigits();
                      textController.text = password;
                    },
                  ),
                  Text(
                    "Digits",
                    style: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Password Length: ",
                      style: TextStyle(color: Colors.purpleAccent)),
                  Text(
                    "${ref.watch(paswordLengthNotifierProvider).toInt()}",
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                  activeTrackColor: Colors.purple,
                  thumbColor: Colors.purpleAccent,
                  inactiveTrackColor: Color(0xFF8D8E98),
                  inactiveTickMarkColor: Color(0xFF8D8E98),
                  activeTickMarkColor: Colors.pink,
                ),
                child: Slider(
                  value: ref.watch(paswordLengthNotifierProvider),
                  divisions: 50,
                  max: 50.0,
                  min: 8,
                  onChanged: (v) {
                    ref
                        .read(paswordLengthNotifierProvider.notifier)
                        .toggleState(v);
                    textController.text = password;
                  },
                  label: ref
                      .watch(paswordLengthNotifierProvider)
                      .toInt()
                      .toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
