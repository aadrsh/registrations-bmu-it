import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

Function(int, bool)? onCompleteOne;
Function(int, bool)? onCompleteTwo;

Future<void> uploadImage(
  int rollno,
  String name,
  Uint8List bytecode,
) async {
  // Create a FormData object
  FormData formData = FormData.fromMap({
    'image': MultipartFile.fromBytes(
      bytecode,
      filename: name,
      contentType:
          MediaType('image', 'jpeg'), // Change this based on your file type
    ),
    'id': rollno
  });

  // Create a Dio instance
  Dio dio = Dio();

  try {
    // Send the request
    Response response = await dio.post(
      'http://10.5.5.52:3000/upload',
      data: formData,
    );

    if (response.statusCode == 200) {
      print('File uploaded successfully');
      callbacks(rollno, true);
    } else {
      print('File upload failed with status: ${response.statusCode}');
      callbacks(rollno, false);
    }
  } catch (e) {
    print('File upload failed: $e');
    callbacks(rollno, false);
  }
}

void callbacks(rollno, bool status) {
  print('calling callbacks');
  if (onCompleteOne != null) {
    onCompleteOne!(rollno, status);
  }
  if (onCompleteTwo != null) {
    onCompleteTwo!(rollno, status);
  }
}

void addOnCompleteOne(Function(int, bool) onComplete) {
  onCompleteOne = onComplete;
}

void addOnCompleteTwo(Function(int, bool) onComplete) {
  onCompleteTwo = onComplete;
}
