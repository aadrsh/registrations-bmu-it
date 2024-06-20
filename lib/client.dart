import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static bool isJarPrepared = false;
  static PersistCookieJar? jar;
  static prepareJar() async {
    if (!isJarPrepared) {
      dio.options.baseUrl = 'http://localhost:3000';
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 3);
      Map<String, String> header = new Map();

      isJarPrepared = true;
    }
  }

  static final dio = Dio();

  static Future<void> getListOfStudents(
      Function(List<dynamic>?, bool) callback) async {
    try {
      Response res = await dio.get('/api/student');
      print(res);
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
