import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CreateLogFile {
  Future getFile() async {
    DateTime now = new DateTime.now().toUtc();
    String filename = "${now.year}-${now.month}-${now.day}.log";
    var path;
    if (Platform.isIOS) {
      path = await getApplicationDocumentsDirectory();
    } else {
      path = await getExternalStorageDirectory();
    }
    String logPath = "${path.toString()}/$filename";
    print(logPath);
    var file = File(logPath);
    if (await file.exists()) {
      return file;
    } else {
      file.create();
      return file;
    }
  }
}
