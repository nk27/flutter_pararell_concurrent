import 'dart:async';

import 'package:flutter/material.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({super.key});

  @override
  _AsyncPageState createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  int _fibonacciResult = 0;
  bool _isCalculating = false;

  Future<int> _calculateFibonacci(int n) async {
    if (n == 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else {
      return await _calculateFibonacci(n - 1) +
          await _calculateFibonacci(n - 2);
    }
  }

  Future<void> _startCalculating() async {
    setState(() {
      _isCalculating = true;
    });
    final result = await _calculateFibonacci(40);

    setState(() {
      _fibonacciResult = result;
      _isCalculating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('非同期処理'),
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
              onPressed: _isCalculating ? null : _startCalculating,
              child: const Text('非同期処理を開始'),
            ),
          ],
        ),
      ),
    );
  }
}
