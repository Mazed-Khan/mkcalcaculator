import 'button.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String operatorr = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff128c7e),
        foregroundColor: Color(0xff312914),
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 30, 30),
                  child: Text(
                    " $number1 $operatorr $number2".isEmpty
                        ? "0"
                        : " $number1 $operatorr $number2",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          //buttons
          Container(
            child: Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: 90, height: 100, child: buildButton(value)),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
        onTapButton(value);
      },
      style: ElevatedButton.styleFrom(
        primary: [Btn.del, Btn.clr, Btn.ac].contains(value)
            ? Colors.blueGrey
            : [Btn.per, Btn.multiply, Btn.divide, Btn.add, Btn.subtract]
                    .contains(value)
                ? Colors.red
                : [Btn.calculate].contains(value)
                    ? Colors.orange
                    : Colors.blue, // Set your preferred button color
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      child: Text(value),
    );
  }

  //Set
  //button values
  void onTapButton(String value) {
    setState(() {
      if (value == Btn.calculate) {
        // Handle calculation
        performCalculation();
      } else if (value == Btn.del) {
        // Handle delete
        handleDelete();
      } else if (value == Btn.ac) {
        // Handle all clear
        handleAllClear();
      } else if (value == Btn.clr) {
        // Handle all clear
        handleAllClear();
      } else {
        // Handle other buttons (numbers and operators)
        handleNumberOrOperator(value);
      }
    });
  }

  void performCalculation() {
    if (number1.isNotEmpty && operatorr.isNotEmpty && number2.isNotEmpty) {
      double result = 0.0;
      double num1 = double.parse(number1);
      double num2 = double.parse(number2);

      switch (operatorr) {
        case Btn.add:
          result = num1 + num2;
          break;
        case Btn.subtract:
          result = num1 - num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.divide:
          if (num2 != 0) {
            result = num1 / num2;
          }
          break;
        case Btn.per:
          if (num2 != 0) {
            result = num1 * num2 / 100;
          }
          break;
      }

      // Update the result or any other UI accordingly
      setState(() {
        number1 = result.toString();
        operatorr = "";
        number2 = "";
      });
    }
  }

  void handleDelete() {
    // Implement logic to delete the last character or handle other delete actions
    setState(() {
      if (number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
      } else if (operatorr.isNotEmpty) {
        operatorr = "";
      } else if (number1.isNotEmpty) {
        number1 = number1.substring(0, number1.length - 1);
      }
    });
  }

  void handleAllClear() {
    // Implement logic to clear all input
    setState(() {
      number1 = "";
      operatorr = "";
      number2 = "";
    });
  }

  void handleNumberOrOperator(String value) {
    // Implement logic to handle number and operator buttons
    // Update number1, operatorr, and number2 accordingly
    if (isOperator(value)) {
      if (number1.isNotEmpty) {
        operatorr = value;
      }
    } else {
      if (operatorr.isEmpty) {
        number1 += value;
      } else {
        number2 += value;
      }
    }
  }

  bool isOperator(String value) {
    return [Btn.per, Btn.multiply, Btn.divide, Btn.add, Btn.subtract]
        .contains(value);
  }
}
