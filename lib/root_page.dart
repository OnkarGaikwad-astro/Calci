import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

String text = "";
TextEditingController controller = TextEditingController();
late String Buttoncolor;
List<int> operators = [2, 3, 7, 11, 15];
List<int> nonvisible = [0, 1, 19];
List<int> signcolor = [1, 2, 3, 7, 11, 15];
List<int> a = [19, 11, 15];
List<String> b = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."];
List<String> Char = [
  "C",
  "",
  "%",
  "/",
  "1",
  "2",
  "3",
  "x",
  "4",
  "5",
  "6",
  "-",
  "7",
  "8",
  "9",
  "+",
  "00",
  "0",
  ".",
  "=",
];

class Rootpage extends StatefulWidget {
  const Rootpage({super.key});

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
void vibrate(){
  Vibration.vibrate(duration: 10);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 40),
            Container(
              height: 207,
              child: TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                controller: controller,
                readOnly: true,
                showCursor: true,
                style: TextStyle(fontSize: 60, color: Colors.white),
                keyboardType: null,
              ),
            ),
            Container(
              height: 30,
            ),
            Divider(height: 10, endIndent: 20, indent: 20),
            SizedBox(height: 10),
            GestureDetector(onTap: calci,
              child: Container(
                height: 535,
                width: 420,
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  children: List.generate(20, (index) {
                    Color initialColor = index == 19
                        ? const Color.fromARGB(201, 91, 219, 245)
                        : const Color.fromARGB(129, 22, 48, 45);
              
                    Color currentColor = initialColor;
              
                    return StatefulBuilder(
                      builder: (context, setInnerState) {
                        return GestureDetector(
                          onTap: () {
                            vibrate();
                            if (index == 1) {
                              text = text.substring(0, text.length - 1);
                              setState(() {});
                            }
                            if (!nonvisible.contains(index)) {
                              if (operators.any(
                                (element) => text.contains(Char[element]),
                              )) {
                                if (operators.contains(index)) {
                                  setState(() {
                                    text = text.replaceFirst(
                                      text[text.length - 1],
                                      Char[index],
                                    );
                                  });
                                  setState(() {
                                    controller.text = text;
                                  });
                                } else {
                                  text = text + Char[index];
                                }
                              } else {
                                text = text + Char[index];
                              }
                            } else {}
                            if (index == 0) {
                              text = "";
                              setState(() {});
                            } else {}
              
                            controller.text = text;
                            setInnerState(() {
                              currentColor = const Color.fromARGB(
                                91,
                                255,
                                255,
                                255,
                              ); // flash color
                            });
                            Future.delayed(const Duration(milliseconds: 100), () {
                              setInnerState(() {
                                currentColor = initialColor; // revert color
                              });
                            });
              
                            if (index == 19) {
                              calci();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Container(
                                color: currentColor,
                                child: Center(
                                  child: index == 1
                                      ? Icon(
                                          Icons.backspace,
                                          size: 30,
                                          color: Colors.grey,
                                        )
                                      : index == 11
                                      ? Icon(
                                          Icons.remove,
                                          size: 40,
                                          color: Colors.teal,
                                        )
                                      : Text(
                                          Char[index],
                                          style: TextStyle(
                                            color: index == 0
                                                ? Colors.red
                                                : signcolor.contains(index)
                                                ? Colors.teal
                                                : Colors.white,
                                            fontSize: a.contains(index) ? 45 : 35,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calci() {
    String answer = "";
    double percent = 100;
    double result = 0;
    String val1 = "";
    String val2 = "";
    late double num1;
    late double num2;
    String operation = "";
    late int val1i;
    for (int i = 0; i < text.length; i++) {
      if (b.contains(text[i])) {
        val1 = val1 + text[i];
        val1i = i;
      } else {
        operation = text[i];
        break;
      }
    }
    for (int i = val1i + 1; i < text.length; i++) {
      if (b.contains(text[i])) {
        val2 = val2 + text[i];
      }
    }
    if (val2 == "") {
      val2 = "0";
    }
    print(val1);
    print(val2);
    print(operation);
    num1 = double.parse(val1);
    num2 = double.parse(val2);
    val1 = "";
    val2 = "";
    if (operation == "+") {
      result = num1 + num2;
    }
    if (operation == "-") {
      result = num1 - num2;
    }
    if (operation == "x") {
      result = num1 * num2;
    }
    if (operation == "/") {
      result = num1 / num2;
    }
    if (operation == "%") {
      if (num2 != 0) {
        percent = num2;
      }
      result = (num1 / percent) * 100;
    }
    if (result % 1 == 0) {
      answer = (result.toInt()).toString();
    } else {
      answer = (result.toStringAsFixed(2)).toString();
    }
    percent = 100;
    controller.text = text = answer;
    setState(() {});
    print(result);
  }
}
