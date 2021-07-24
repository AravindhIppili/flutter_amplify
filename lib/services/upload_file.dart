import 'dart:io';

import 'package:amplify_flutter/amplify.dart';

class Storage {
  Future<String?> uploadFile(File file) async {
    try {
      final fileName = DateTime.now().toIso8601String();
      final result =
          await Amplify.Storage.uploadFile(local: file, key: fileName + ".jpg");
      return result.key;
    } catch (e) {
      throw e;
    }
  }
}
