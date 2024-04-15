import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String equation = '';
  String result = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '';
        result = '';
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
      } else if (buttonText == '=') {
        try {
          result = _evaluateEquation(equation);
        } catch (e) {
          result = 'Error';
        }
      } else {
        equation += buttonText;
      }
    });
  }

  String _evaluateEquation(String equation) {
    try {
      // Simple evaluation logic for demonstration
      return evalExpression(equation).toString();
    } catch (e) {
      return 'Error';
    }
  }

  double evalExpression(String expression) {
    // Basic expression evaluation logic
    // You can implement more sophisticated logic here if needed
    return Function.apply((num1, operator, num2) {
      switch (operator) {
        case '+':
          return num1 + num2;
        case '-':
          return num1 - num2;
        case 'x':
          return num1 * num2;
        case '/':
          return num1 / num2;
        default:
          throw Exception('Invalid operator');
      }
    }, [
      double.parse(expression.split(RegExp(r'[^\d\.]+'))[0]),
      expression.replaceAll(RegExp(r'\d+|\.'), '').trim(),
      double.parse(expression.split(RegExp(r'[^\d\.]+'))[1])
    ]);
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Text(
              result,
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                buildButton('C', 0.3, Colors.grey),
                buildButton('⌫', 0.3, Colors.grey),
                buildButton('%', 0.3, Colors.grey),
                buildButton('/', 0.3, Colors.amber),
                buildButton('7', 0.3, Colors.white),
                buildButton('8', 0.3, Colors.white),
                buildButton('9', 0.3, Colors.white),
                buildButton('x', 0.3, Colors.amber),
                buildButton('4', 0.3, Colors.white),
                buildButton('5', 0.3, Colors.white),
                buildButton('6', 0.3, Colors.white),
                buildButton('-', 0.3, Colors.amber),
                buildButton('1', 0.3, Colors.white),
                buildButton('2', 0.3, Colors.white),
                buildButton('3', 0.3, Colors.white),
                buildButton('+', 0.3, Colors.amber),
                buildButton('.', 0.3, Colors.white),
                buildButton('0', 0.3, Colors.white),
                buildButton('00', 0.3, Colors.white),
                buildButton('=', 0.3, Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
