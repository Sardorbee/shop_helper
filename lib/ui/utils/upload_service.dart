import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_helper/service/model/universal_data.dart';

class ImageHandler {
  static Future<UniversalData> imageUploader(XFile xFile) async {
    String downloadUrl = "";
    try {
      final storageRef = FirebaseStorage.instance.ref();
      var imageRef = storageRef.child("images/profileImages/${xFile.name}");
      await imageRef.putFile(File(xFile.path));
      downloadUrl = await imageRef.getDownloadURL();

      return UniversalData(data: downloadUrl);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<String> fileUploader(File file, String fileName) async {
    String downloadUrl = "";
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("files/pdf/$fileName");
    await imageRef.putFile(File(file.path));
    downloadUrl = await imageRef.getDownloadURL();
    print("FILE DOWNLOAD URL:$downloadUrl");
    return downloadUrl;
  }
}
