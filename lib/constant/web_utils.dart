import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
class PickedImageData {
  final String name;
  final Uint8List data;

  PickedImageData(this.name, this.data);
}
class FileUtilsWeb {

  static Future<PickedImageData?> pickImage(type) async {
    final result = await FilePicker.platform.pickFiles(
      type:type,
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return null;
    final files = result.files;
    final name = files.first.name;
    final data = files.first.bytes ?? Uint8List(0);
    return PickedImageData(name, data);
  }
  static Future<PickedImageData?> pickDocument(type) async {
    final result = await FilePicker.platform.pickFiles(
      type:type,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return null;
    final files = result.files;
    final name = files.first.name;
    final data = files.first.bytes ?? Uint8List(0);
    return PickedImageData(name, data);
  }
  static Future<List<Uint8List>?> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return null;
    final files = result.files;
    return files.map((e) => e.bytes ?? Uint8List(0)).toList();
    // return files.map((e) => html.File(e.bytes?.toList() ?? [], e.name, {'type': e.extension})).toList();
  }

  static Future<io.File> convertHtmlFileToIoFile(html.File htmlFile) async {
    List<int> bytes = await getBytesFromHtmlFile(htmlFile);
    String fileName = htmlFile.name;
    io.File ioFile = new io.File(fileName);
    await ioFile.writeAsBytes(bytes);
    return ioFile;
  }

  static Future<List<int>> getBytesFromHtmlFile(html.File file) async {
    html.FileReader reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    List<int> bytes = reader.result as List<int>;
    return bytes;
  }

  static Future<List<int>> fileToBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    return reader.result as List<int>;
  }

  _startFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    var files = <io.File>[];

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
    });
  }

  static Future<List<Uint8List>?> pickMultipleFiles(FileType type) async {
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return null;
    final files = result.files;
    return files.map((e) => e.bytes ?? Uint8List(0)).toList();
    // return files.map((e) => html.File(e.bytes?.toList() ?? [], e.name, {'type': e.extension})).toList();
  }
  static Future<String> uploadSingleImageToFirebase(Uint8List file, String filePath) async {
    final ref = FirebaseStorage.instance.ref(filePath);
    final task = ref.putData(file, SettableMetadata(contentType: "image/png"));
    final snapshot = await task.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();


    return url;
  }


  static Future<String> UploadSingleDocumentToFirebase(Uint8List fileData, String filePath) async {
    try {
      final ref = FirebaseStorage.instance.ref(filePath);
      final task = ref.putData(fileData);
      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('File upload error: $e');
      return '';
    }
  }


  static Future<String> uploadSingleDocumentToFirebase(Uint8List file, String filePath) async {
    final ref = FirebaseStorage.instance.ref(filePath);
    final task = ref.putData(file, SettableMetadata(contentType: "'pdf', 'doc', 'docx'"));
    final snapshot = await task.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }
  static Future<String> uploadSingleAudioToFirebase(Uint8List file, String filePath) async {
    final ref = FirebaseStorage.instance.ref(filePath);
    final task = ref.putData(file, SettableMetadata(contentType: "audio/mp3"));
    final snapshot = await task.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

 static Future<List<String>> uploadMultipleImagesToFirebase(List<Uint8List> files, String folderPath) async {
    final List<String> downloadUrls = [];

    for (int i = 0; i < files.length; i++) {
      final Uint8List file = files[i];
      final filePath = '$folderPath/image_$i.png'; // Change this naming scheme as per your requirements

      final ref = FirebaseStorage.instance.ref(filePath);
      final task = ref.putData(file, SettableMetadata(contentType: "image/png"));

      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    }

    return downloadUrls;
  }

  static Future<List<String>> uploadImagesToFirebase(
      List<Uint8List> files, String folderPath,
      {Function(int index)? onFileChange}) async {
    List<String> urls = [];

    await Future.forEach(files, (Uint8List e) async {
      int index = files.indexOf(e);
      if (onFileChange != null) {
        onFileChange(index);
      }

      // final reader = html.FileReader();
      // reader.readAsArrayBuffer(e);

      var filePath = folderPath + "/image${index}.png";
      final ref = FirebaseStorage.instance.ref(filePath);
      print(filePath);

      // final bytes = reader.result as Uint8List;
      // var file = await FileUtilsWeb.convertHtmlFileToIoFile(e);
      // var bytes = await FileUtilsWeb.fileToBytes(e);
      final task = ref.putData(e, SettableMetadata(contentType: "image/png"));
      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      urls.add(url);
      print(url);
    });

    return urls;
  }


}