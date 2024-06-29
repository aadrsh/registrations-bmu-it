import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static bool isJarPrepared = false;
  static PersistCookieJar? jar;
  static prepareJar() async {
    if (!isJarPrepared) {
      dio.options.baseUrl = 'http://10.5.5.52:3000';
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 3);
      isJarPrepared = true;
    }
  }

  static final dio = Dio();

  static Future<void> getListOfStudents(
      String searchTerm, Function(List<dynamic>?, bool) callback) async {
    try {
      Response res = await dio
          .get('/api/students', queryParameters: {'searchTerm': searchTerm});

      if (res.statusCode == 200) {
        callback(res.data, false);
      } else {
        callback(null, true);
      }
    } catch (e) {
      callback(null, true);
    }
  }

  static Future<void> addNewStudent(
      String name, Function(dynamic, bool) callback) async {
    dynamic body = {"name": name};
    try {
      Response res = await dio.post('/api/students', data: body);
      print('created');
      print(res.statusCode);
      if (res.statusCode == 201) {
        callback(res.data, false);
      } else {
        callback(null, true);
      }
    } catch (e) {
      callback(null, true);
    }
  }

  static Future<void> getImage(int rollno,
      Function(Uint8List? imageByteArray, bool error) callback) async {
    try {
      String imageUrl = '/uploads/${rollno}.jpg';

      // Fetch image byte data from network
      Response response = await dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        // Convert response data to Uint8List
        callback(Uint8List.fromList(response.data), false);
      } else {
        print('Failed to load image: ${response.statusCode}');
        callback(null, false);
      }
    } catch (e) {
      print('Error loading image: $e');
      callback(null, false);
    }
  }

  static Future<void> getStatusCount(
      Function(int photoCount, int bioCount, bool error) callback) async {
    try {
      Response res = await dio.get('/api/students/statusCount');
      if (res.statusCode == 200) {
        print(res.data);
        callback(res.data['photoStatusCount'], res.data['biometricStatusCount'],
            false);
      } else {
        callback(0, 0, true);
      }
    } catch (e) {
      callback(0, 0, true);
    }
  }

  static Future<void> getStudentById(
      int id, Function(dynamic, bool) callback) async {
    try {
      Response res = await dio.get('/api/students/$id');
      if (res.statusCode == 200) {
        callback(res.data, false);
      } else {
        callback(null, true);
      }
    } catch (e) {
      callback(null, true);
    }
  }
}
