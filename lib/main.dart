// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  bool validateInputs(
      List<int> expectedValues, List<TextEditingController> controllers) {
    final inputValues = controllers
        .map((controller) => int.tryParse(controller.text) ?? 0)
        .toList();
    return inputValues.length == expectedValues.length &&
        const ListEquality().equals(inputValues, expectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final controllers = List.generate(9, (_) => TextEditingController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.ibb.co/5jFFxQn/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int row = 0; row < 3; row++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int col = 0; col < 3; col++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: SizedBox(
                              width: 60,
                              height: 36,
                              child: TextFormField(
                                controller: controllers[row * 3 + col],
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 3,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  final expectedValues = [40, 20, 10, 50, 40, 10, 50, 40, 30];
                  if (validateInputs(expectedValues, controllers)) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Başarılı'),
                        content: const Text('Tebrikler cevaplarınız doğru.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Kapat'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hata'),
                        content: const Text('Cevaplarınızı kontrol ediniz.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Kapat'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(0, 145),
                ),
                child:
                    const Text('H       e      s      a      p      l      a'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
