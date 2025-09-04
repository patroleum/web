import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patroleum_dashboard/core/error_interceptor.dart';
import 'package:patroleum_dashboard/core/singleton/local_storage_singleton.dart';

class DioSingleton {
  factory DioSingleton() {
    _instance ??= DioSingleton._();
    return _instance!;
  }

  DioSingleton._();

  static DioSingleton? _instance;

  static late final Dio dio;

  static bool initSingletonbool = true;


  static void createDio() {
    if (initSingletonbool) {
      dio = Dio(
        BaseOptions(
        baseUrl: 'https://api.patroleum.net/api/',
          receiveTimeout: const Duration(minutes: 7),
          connectTimeout: const Duration(minutes: 7),
          sendTimeout: const Duration(minutes: 7),
          contentType: 'application/json; charset=UTF-8',
        ),
      );
      initSingletonbool = false;

    }
  }

  static void dioInterceptor() {
    dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: false,
        logResponseHeaders: false,

        logger: debugPrint,
    ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = LocalStorageSingleton.getToken();
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
