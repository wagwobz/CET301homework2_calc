import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String backResult = '0';
  double result = 0.0;
  String strResult = '0';
  String operator = '';
  double firstNumber;

  bool isFirstNumberAfterOperationButton = true;
  bool isOperationActive = false;
  bool isOperationFinished = false;

  void onDigitPress(String text) {

    setState(() {
      if(isOperationFinished){
        result=0;
        strResult='0';
        isOperationFinished = false;
      }
    });

    print('digit pressed = $text');
    if (text == '+') {
      operator = text;
      firstNumber = result;
      strResult = '';

      isFirstNumberAfterOperationButton = true;

      setState(() {
        backResult = '$firstNumber$text';
      });
    }
    else if (text == '-') {

      operator = text;
      firstNumber = result;
      strResult = '';

      isFirstNumberAfterOperationButton = true;

      setState(() {
        backResult = '$firstNumber$text';
      });

    }
    else if (text == '÷') {
      operator = text;
      firstNumber = result;
      strResult = '';

      isFirstNumberAfterOperationButton = true;

      setState(() {
        backResult = '$firstNumber$text';
      });
    }
    else if (text == '*') {
      operator = text;
      firstNumber = result;
      strResult = '';

      isFirstNumberAfterOperationButton = true;

      setState(() {
        backResult = '$firstNumber$text';
      });
    }
    else if (text == '=') {
      switch (operator) {
        case '+':
          setState(() {
            backResult = backResult + result.toString();
            result = firstNumber+ result ;
          });
          strResult = '$result';
          break;
        case '-':
          setState(() {
            backResult = backResult + result.toString();
            result = firstNumber-result;
          });
          strResult = '$result';
          break;
        case '÷':
          setState(() {
            backResult = backResult + result.toString();
            result = firstNumber/result;
          });
          strResult = '$result';
          break;
        case '*':
          setState(() {
            backResult = backResult + result.toString();
            result = firstNumber*result;
          });
          strResult = '$result';
          break;

      }
      isOperationFinished=true;

    }
    else if(text == '<-') {
      if(strResult == '') {
        strResult = '';
      }
      else {
        setState(() {
          strResult = strResult.substring(0, strResult.length -1 );
          print(strResult);
        });
        var tempResult;
        if (isFirstNumberAfterOperationButton) {
          tempResult = text;
          isFirstNumberAfterOperationButton = false;
        } else {
          setState(() {
            tempResult = strResult;
          });
        }
        var temp = double.tryParse(tempResult);
        if (temp != null) {
          strResult = tempResult;
          setState(() {
            result = temp ?? result;
          });
        }
        if (temp==null) {
          setState(() {
            result=0;
          });
        }
      }
    }


    else if (text == '.') {
        if(strResult=='0'){
          setState(() {
            strResult='0.';
          });
        }
        else {
        strResult=strResult+'.';
        }
    }
    else if (text == 'C') {
      backResult = '0';
      setState(() {
        result = 0.0;
      });
      strResult = '0';
      operator = '';

      isFirstNumberAfterOperationButton = true;
      isOperationActive = false;
      isOperationFinished = false;
    }

    else {
      var tempResult;
      if (isFirstNumberAfterOperationButton) {
        tempResult = text;
        isFirstNumberAfterOperationButton = false;
      } else {
        print(strResult);
        tempResult = strResult + text;
      }
      var temp = double.tryParse(tempResult);
      if (temp != null) {
        strResult = tempResult;
        setState(() {

          result = temp ?? result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calc"),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$backResult',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$result',
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('C', Colors.deepOrange, 2),
                  buildCalcButton('<-', Colors.blueGrey, 1),
                  buildCalcButton('÷', Colors.blueAccent, 1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('7', Colors.black26, 1),
                  buildCalcButton('8', Colors.black26, 1),
                  buildCalcButton('9', Colors.black26, 1),
                  buildCalcButton('*', Colors.blueAccent, 1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('4', Colors.black26, 1),
                  buildCalcButton('5', Colors.black26, 1),
                  buildCalcButton('6', Colors.black26, 1),
                  buildCalcButton('-', Colors.blueAccent, 1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('1', Colors.black26, 1),
                  buildCalcButton('2', Colors.black26, 1),
                  buildCalcButton('3', Colors.black26, 1),
                  buildCalcButton('+', Colors.blueAccent, 1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('.', Colors.black45, 1),
                  buildCalcButton('0', Colors.black26, 1),
                  buildCalcButton('00', Colors.black26, 1),
                  buildCalcButton('=', Colors.indigo, 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCalcButton(String text, Color color, int flex) {
    return Expanded(
      flex: flex,
      child: FlatButton(
          onPressed: () {
            onDigitPress(text);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          color: color,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          )),
    );
  }
}
