import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

Future<void> uploadImage(
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
    } else {
      print('File upload failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('File upload failed: $e');
  }
}
