import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';
//import 'dart:isolate';

class ComputePage extends StatefulWidget {
  const ComputePage({super.key});

  @override
  _ComputePageState createState() => _ComputePageState();
}

class _ComputePageState extends State<ComputePage> {
  int _fibonacciResult = 0;
  bool _isCalculating = false;

  Future<int> _calculateFibonacci(int n) async {
    return await compute(_fibonacci, n);
  }

  static int _fibonacci(int n) {
    if (n == 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else {
      return _fibonacci(n - 1) + _fibonacci(n - 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('compute()処理'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isCalculating)
              const CircularProgressIndicator()
            else if (_fibonacciResult != 0)
              Text('計算結果: $_fibonacciResult'),
            ElevatedButton(
              onPressed: _isCalculating
                  ? null
                  : () {
                      setState(() {
                        _isCalculating = true;
                      });
                      _calculateFibonacci(40).then((result) {
                        setState(() {
                          _fibonacciResult = result;
                          _isCalculating = false;
                        });
                      });
                    },
              child: const Text('compute()処理を開始'),
            ),
          ],
        ),
      ),
    );
  }
}
