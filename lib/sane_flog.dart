library sane_flog;

import 'dart:core';
//import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';

enum Level { INFO, DEBUG, WARN, ERROR }

class Logger {
  // static String URI = '';
  var db;
  _init() async {
    db = await Db.create(
        'mongodb+srv://teamin:loggingchad@logging.ock5l.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
  }

  _close() async {
    await db.close();
  }

  // Logger(String uri) {
  //   URI = uri;
  // }

  Logger() {
    _init();
  }

  Future log(Level level, String screen, String component, String klass,
      String message) async {
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
    Map<String, dynamic> logLine = {
      'timestamp': '${DateTime.now().toUtc()}',
      'level': loglevel,
      'message': '${screen}:${component}:${klass} => ${message}',
      'location': 'flutter'
    };

    var collectionName = 'logs';
    var collection = db.collection(collectionName);

    await collection.insertOne(logLine).then((result) async {
      //Success!
    }).catchError((error) async {
      throw error;
    });

    // var url = Uri.parse(URI);
    // var response = await http.post(url, body: logLine);
    // if (response.statusCode != 201) {
    //   throw "Error logging: ${response.body}";
    // }
  }
}