import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    '+': 0,
    '-': 1,
    '*': 2,
    '/': 3,
  };

  double? _number1;
  double? _number2;

  String? _startMeasure;

  final List<String> _measures = [
    '+',
    '-',
    '*',
    '/',
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );

    return MaterialApp(
        title: 'Measures Converter',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Measures Converter'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 700.0),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            'Value1',
                            style: labelStyle,
                          ),
                          Spacer(),
                          TextField(
                            style: inputStyle,
                            onChanged: (text) {
                              var rv = double.tryParse(text);
                              if (rv != null) {
                                setState(() {
                                  _number1 = rv;
                                });
                              }
                            },
                          ),
                          Spacer(),
                          Text(
                            'Operator',
                            style: labelStyle,
                          ),
                          DropdownButton(
                            isExpanded: true,
                            items: _measures.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: inputStyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _startMeasure = value;
                              });
                            },
                            value: _startMeasure,
                          ),
                          Spacer(),
                          Text(
                            'Value2',
                            style: labelStyle,
                          ),
                          Spacer(),
                          TextField(
                            style: inputStyle,
                            onChanged: (text) {
                              var rv = double.tryParse(text);
                              if (rv != null) {
                                setState(() {
                                  _number2 = rv;
                                });
                              }
                            },
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          ElevatedButton(
                            child: Text('Calculator', style: inputStyle),
                            onPressed: () {
                              calculator(_number1!, _number2!, _startMeasure!);
                            },
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text((_resultMessage == null) ? '' : _resultMessage!,
                              style: labelStyle),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  void calculator(double value1, double value2, String operator) {
    int op = _measuresMap[operator]!;
    double? result;
    if (op == 0) {
      result = value1 + value2;
    } else if (op == 1) {
      result = value1 - value2;
    } else if (op == 2) {
      result = value1 * value2;
    } else if (op == 3) {
      result = value1 / value2;
    }
    _resultMessage = '${result.toString()}';
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  String? _resultMessage;
}
