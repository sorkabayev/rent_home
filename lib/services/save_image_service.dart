import 'dart:async';
import 'dart:io' as Io;
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Uint8List> getImageFromNetwork(String url) async {
    final response = await get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<Io.File> saveImage(String url) async {
    final imageUint8List = await getImageFromNetwork(url);

    var path = '${await _localPath}/images';
    await Io.Directory(path).create(recursive: true);

    return Io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(imageUint8List);
  }
}
