import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patroleum_dashboard/core/dio_client.dart';

class RestLoginProvider {

  Future<Either<Exception, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {

      final response = await DioClient().dio.post(
        'https://api.patroleum.net/api/auth',
        // '$baseUrl/auth',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode(
            {'email': email, 'secret': password, 'firebase': 'test'}),
      );
      //print('fatima login ${response}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['token'] != null &&
            responseData['refreshToken'] != null) {
              print( responseData );
          // await TokenStorage.saveToken(
          //     responseData['token'],
          //     responseData['refreshToken'],
          //     responseData['tokenDSS'],
          //     responseData['signature'],
          //     responseData['user']['id_user']);
          return responseData;
        } else {
          return Left(Exception('Response data incomplete'));
        }
      } else {
        return Left(Exception('Login failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }

  }

}