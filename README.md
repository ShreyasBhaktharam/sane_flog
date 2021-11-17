# sane_flog

[![pub package](https://img.shields.io/badge/pub-v0.0.2-blue)](https://pub.dev/packages/sane_flog)

A sane flutter api logging library.

## How to use
```dart
// initialize logger
...
final logger = Logger('<url_of_api_to_log_to>');
...

// enum Level
enum Level {
  INFO,
  DEBUG,
  WARN,
  ERROR
}

// log level <level>
...
await logger.log(Level.<level>, 'homepage', 'popup', 'PopUpHandler', 'popup triggered');
...
```
