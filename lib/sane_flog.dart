library sane_flog;

import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:synchronized/synchronized.dart';
import 'package:dio/dio.dart' hide Lock;
import 'package:sane_flog/create_flog.dart';

class JsonLogger {
  static final _lock = Lock();
  File _logFile = File('');
  static bool logToConsole = false;

  Future initializeLogging(bool logToFile, [bool console = false]) async {
    logToConsole = console;
    if (logToFile) {
      if (!logToConsole) {
        var logFile = CreateLogFile();
        _logFile = await logFile.getFile(true);
      }
    }
    print("Logging started!\n");
  }

  Future log(String level, String component, String log, bool logToFile) async {
    Map<String, String> logLine = {
      'timestamp': '${DateTime.now().toUtc()}',
      'level': '',
      'component': '',
      'log': ''
    };
    switch (level.toUpperCase()) {
      case 'INFO':
        logLine['level'] = 'INFO';
        break;
      case 'DEBUG':
        logLine['level'] = 'DEBUG';
        break;
      case 'WARN':
        logLine['level'] = 'WARN';
        break;
      case 'ERROR':
        logLine['level'] = 'ERROR';
        break;
    }
    logLine['component'] = component;
    logLine['log'] = log;
    if (logToFile) {
      if (logToConsole) {
        return logLine;
      } else {
        return _lock.synchronized(() async {
          await _logFile.writeAsString(jsonEncode(logLine),
              mode: FileMode.append, flush: true);
        });
      }
    } else {
      try {
        final resp = await Dio()
            .post("https://teaminbackend.herokuapp.com/log/frontend", data: logLine);
        if (resp.statusCode == 200) {
          print("logged succesfully");
        } else {
          print("logging failed")
        }
      } on DioError catch (e) {
        //print(e.response.data);
        throw Exception('Failed to send request to logging route');
      }
    }
  }
}
