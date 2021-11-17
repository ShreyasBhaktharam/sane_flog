library sane_flog;

import 'dart:core';
import 'package:http/http.dart' as http;

enum Level {
  INFO,
  DEBUG,
  WARN,
  ERROR
}

class Logger {
  static String URI = '';
  Logger(String uri) {
    URI = uri;
  }

  Future log(Level level, String screen, String component, String klass, String message) async {
    String loglevel;
    switch (level) {
      case Level.INFO:
        loglevel = 'INFO';
        break;
      case Level.DEBUG:
        loglevel = 'DEBUG';
        break;
      case Level.WARN:
        loglevel = 'WARN';
        break;
      case Level.ERROR:
        loglevel = 'ERROR';
        break;
    }
    Map<String, String> logLine = {
      'timestamp': '${DateTime.now().toUtc()}',
      'level': loglevel,
      'message': '${screen}:${component}:${klass} => ${message}',
      'location': 'flutter'
    };
    var url = Uri.parse(URI);
    var response = await http.post(url, body: logLine);
    if (response.statusCode != 201) {
      throw "Error logging: ${response.body}";
    }
  }
}
