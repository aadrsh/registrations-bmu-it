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

  static Future<void> addNewStudent(String firstName, String lastName,
      Function(dynamic, bool) callback) async {
    dynamic body = {"firstName": firstName, "lastName": lastName};
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
