import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find X Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Findx(),
    );
  }
}

class Findx extends StatefulWidget {
  @override
  _FindxState createState() => _FindxState();
}

class _FindxState extends State<Findx> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double euationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        double euationFontSize = 38.0;
        double resultFontSize = 48.0;
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        double euationFontSize = 38.0;
        double resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('+', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'error';
        }
      } else {
        double euationFontSize = 38.0;
        double resultFontSize = 48.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), //FOR  BUTTON
          side: BorderSide(
              color: Colors.white, width: 9, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find X Calculator'),
        centerTitle: true,
        toolbarHeight: 70.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: euationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.red),
                    buildButton('⌫', 1, Colors.blue[400]),
                    buildButton("﹢", 1, Colors.blue[400]),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.black45),
                    buildButton('8', 1, Colors.black45),
                    buildButton("9", 1, Colors.black45),
                  ]),
                  TableRow(children: [
                    buildButton("6", 1, Colors.black45),
                    buildButton('5', 1, Colors.black45),
                    buildButton("4", 1, Colors.black45),
                  ]),
                  TableRow(children: [
                    buildButton("3", 1, Colors.black45),
                    buildButton('2', 1, Colors.black45),
                    buildButton("1", 1, Colors.black45),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.black45),
                    buildButton('0', 1, Colors.black45),
                    buildButton("00", 1, Colors.black45),
                  ]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("×", 1, Colors.blue[400]),
                  ]),
                  TableRow(children: [
                    buildButton("-", 1, Colors.blue[400]),
                  ]),
                  TableRow(children: [
                    buildButton("/", 1, Colors.blue[400]),
                  ]),
                  TableRow(children: [
                    buildButton('=', 2, Colors.blue[400]),
                  ]),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}
