import 'package:flutter_test/flutter_test.dart';

import 'dart:core';

import 'package:sane_flog/sane_flog.dart';

void main() {
  test('Tests log level info', () async {
    final logger = JsonLogger();
    logger.initializeLogging('test.out', true);
    final expected = {
      'level': 'INFO',
      'component': 'main',
      'log': 'Hello There!'
    };
    final res = await logger.log('Info', 'main', "Hello There!");
    expect(res['level'], expected['level']);
    expect(res['component'], expected['component']);
    expect(res['log'], expected['log']);
  });
  test('Tests log level warn', () async {
    final logger = JsonLogger();
    logger.initializeLogging('test.out', true);
    final expected = {
      'level': 'WARN',
      'component': 'main',
      'log': 'Hello There!'
    };
    final res = await logger.log('Warn', 'main', "Hello There!");
    expect(res['level'], expected['level']);
    expect(res['component'], expected['component']);
    expect(res['log'], expected['log']);
  });
  test('Tests log level debug', () async {
    final logger = JsonLogger();
    logger.initializeLogging('test.out', true);
    final expected = {
      'level': 'DEBUG',
      'component': 'main',
      'log': 'Hello There!'
    };
    final res = await logger.log('Debug', 'main', "Hello There!");
    expect(res['level'], expected['level']);
    expect(res['component'], expected['component']);
    expect(res['log'], expected['log']);
});
  test('Tests log level error', () async {
    final logger = JsonLogger();
    logger.initializeLogging('test.out', true);
    final expected = {
      'level': 'ERROR',
      'component': 'main',
      'log': 'Hello There!'
    };
    final res = await logger.log('Error', 'main', "Hello There!");
    expect(res['level'], expected['level']);
    expect(res['component'], expected['component']);
    expect(res['log'], expected['log']);
  });
}
