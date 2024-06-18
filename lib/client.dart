import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';


class DioHelper {
  static bool isJarPrepared = false;
  static PersistCookieJar? jar;
  static prepareJar() async {
    if (!isJarPrepared) {
      dio.options.baseUrl = 'https://3000-idx-registrations-api-1718550013015.cluster-fu5knmr55rd44vy7k7pxk74ams.cloudworkstations.dev';
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 3);
      isJarPrepared = true;
    }
  }

  static final dio = Dio();


static Future<void> getListOfStudents(Function(List<dynamic>?, bool) callback) async {
  try {
    Response res = await Dio().get('/api/student'); 
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


