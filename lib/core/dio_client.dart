import 'package:dio/dio.dart';
import 'package:patroleum_dashboard/core/error_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({
    String? baseUrl,
    bool loading = false,
  }) : dio = Dio(BaseOptions(
    baseUrl: 'https://api.patroleum.net/api/',
    contentType: 'application/json; charset=UTF-8',
    receiveDataWhenStatusError: true,
    validateStatus: (_) => true,
  )) {

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO(PENDIENTE): Obtener el token para las peticiones desde las localNotifications
          final token = '';
          // final token = TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['x-token'] = token;
          }
          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(ErrorInterceptors(dio));

  }
}
