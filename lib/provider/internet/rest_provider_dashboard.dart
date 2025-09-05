// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patroleum_dashboard/core/singleton/dio_singleton.dart';
import 'package:patroleum_dashboard/core/singleton/local_storage_singleton.dart';

class RestDashboardProvider {

  Future<Either<Exception, String>> getVideoUrl({
    required String userId,
    required String channelId,
  }) async {
    try {

      final token =  LocalStorageSingleton.getToken();
      final tokenDSS =  LocalStorageSingleton.getTokenDSS();

      if (token == null) {
        return Left(Exception('No token found'));
      }

      final response = await DioSingleton.dio.post(
        'https://api.patroleum.net/api/video/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-token': token, 
          },
        ),
        data: jsonEncode({
          'tokenDSS': tokenDSS,
          'channelId': channelId,
        }),
      );

      if (response.statusCode == 200) {
        return response.data['data']['url2'];
      } else {
        print('Failed to load video URL: ${response.data}');
        return Left(Exception('Failed to load video URL: ${response.data}'));
      }


    } catch (e) {
      return Left(Exception(e.toString()));
    }

  }

}