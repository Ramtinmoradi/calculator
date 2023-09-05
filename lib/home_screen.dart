import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var inputUser = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 40,
            child: Container(
              color: backgroundGreyDark,
              child: _getUserInput(),
            ),
          ),
          Expanded(
            flex: 60,
            child: Container(
              color: backgroundGrey,
              child: _getKeyBoard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getUserInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            inputUser,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: textGreen,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            result,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: textGrey,
            ),
          ),
        ),
      ],
    );
  }

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget _getKeyBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getRow(text1: 'AC', text2: 'CL', text3: '%', text4: '/'),
        _getRow(text1: '7', text2: '8', text3: '9', text4: '*'),
        _getRow(text1: '4', text2: '5', text3: '6', text4: '-'),
        _getRow(text1: '1', text2: '2', text3: '3', text4: '+'),
        _getRow(text1: '00', text2: '0', text3: '.', text4: '='),
      ],
    );
  }

  Widget _getRow({
    required String text1,
    required String text2,
    required String text3,
    required String text4,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(text1),
            shape: CircleBorder(
              side: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                result = '';
                inputUser = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: getOperatorColor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(text2),
            shape: CircleBorder(
              side: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text2 == 'CL') {
              setState(() {
                if (inputUser != '') {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: getOperatorColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(text3),
            shape: CircleBorder(
              side: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: getOperatorColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(text4),
            shape: CircleBorder(
              side: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: getOperatorColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var list = ['AC', 'CL', '%', '/', '*', '-', '+', '='];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }

    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getOperatorColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
