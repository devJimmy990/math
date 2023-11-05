import 'dart:math' as math;
import 'package:bloc/bloc.dart';
import 'package:math/bloc/calculator/calculator_state.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic extends Cubit<CalculatorState> {
  CalculatorLogic() : super(InitCalculatorState());
  String _equation = "0", _expression = "", _result = "0";
  bool _isOperation = false;
  bool _isSpecial = false;

  void _clear() {
    _result = "0";
    _equation = "0";
    _expression = "";
    emit(ResetCalculator());
  }

  void _backspace() {
    if (_equation.length == 1) {
      _clear();
    } else {
      _equation = _equation.substring(0, _equation.length - 1);
    }
    emit(BackspaceText());
  }

  void _calculate() {
    if (!_isLastOperation()) _backspace();
    _expression = _equation
        .replaceAll(
          '×',
          '*',
        )
        .replaceAll(
          '÷',
          '/',
        )
        .replaceAll(
          'X!',
          '!',
        )
        .replaceAll(
          'π',
          '${math.pi}',
        )
        .replaceAll(
          'e',
          '${math.e}',
        );
    _result = _calculateExpression(_expression);
  }

  void _addText(String text) {
    if (_equation == '0') {
      _equation = text;
    } else {
      _equation = _equation + text;
    }

    emit(AddTextEquation());
    //if (_canCalculate()) _calculate();
  }

  String _handleResult(double res) {
    String decimal =
        res.toString().contains(".") ? res.toString().split(".")[1] : "";
    return res % 1 == 0
        ? res.toInt().toString()
        : decimal.length <= 6
            ? res.toDouble().toString()
            : res.toStringAsFixed(6).toString();
  }

  String _calculateExpression(String expression) {
    try {
      final exp = Parser().parse(expression);
      final contextModel = ContextModel();
      final double fResult = exp.evaluate(EvaluationType.REAL, contextModel);
      return _handleResult(fResult);
    } catch (e) {
      return 'Error $e';
    } finally {
      emit(PerformCalculation());
    }
  }

  bool _canCalculate() {
    if (_equation.contains("÷") ||
        _equation.contains("×") ||
        _equation.contains("-") ||
        _equation.contains("+")) {
      if (_equation[_equation.length - 1] != "÷" &&
          _equation[_equation.length - 1] != "×" &&
          _equation[_equation.length - 1] != "+" &&
          _equation[_equation.length - 1] != "-") {
        return true;
      }
    }
    return false;
  }

  bool _isLastOperation() {
    if (_equation[_equation.length - 1] == "÷" ||
        _equation[_equation.length - 1] == "×" ||
        _equation[_equation.length - 1] == "+" ||
        _equation[_equation.length - 1] == "-") {
      return false;
    }
    return true;
  }

  void getPressedText(String text) {
    if (text == 'sin') {
      _isSpecial = true;
      _addText('sin(');
    } else if (text == 'cos') {
      _isSpecial = true;
      _addText('cos(');
    } else if (text == 'tan') {
      _isSpecial = true;
      _addText('tan(');
    } else if (text == '√x') {
      _isSpecial = true;
      _addText('sqrt(');
    } else if (text == '1⁄x') {
      _isSpecial = true;
      _addText('1/');
    } else if (text == '?') {
      _isSpecial = true;
      _addText('rand()');
    } else if (text == 'ln') {
      _isSpecial = true;
      _addText('ln(');
    } else if (text == 'log') {
      _isSpecial = true;
      _addText('log10(');
    } else if (text == 'x^y') {
      _isSpecial = true;
      _addText('^');
    } else if (text == 'X!') {
      _isSpecial = true;
      _addText('!');
    } else if (text == 'AC') {
      _clear();
    } else if (text == '⌫') {
      _backspace();
    } else if (text == '=') {
      _calculate();
    } else if (text == "+" || text == "-" || text == "×" || text == "÷") {
      _isOperation = true;
      if (!_isLastOperation()) _backspace();
      _addText(text);
    } else {
      _addText(text);
    }
  }

  String get getResult => _result;

  String get getEquation => _equation;
}
