// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patroleum_dashboard/core/singleton/dio_singleton.dart';
import 'package:patroleum_dashboard/core/singleton/local_storage_singleton.dart';
import 'package:patroleum_dashboard/data/model/user_model.dart';

class RestLoginProvider {

  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {

      final response = await DioSingleton.dio.post(
        'https://api.patroleum.net/api/auth',
        // '/auth',
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

              final user = UserModel.fromJson(responseData);

              // await LocalStorageSingleton.saveToken(
              //     responseData['token'],
              //     responseData['refreshToken'],
              //     responseData['tokenDSS'],
              //     responseData['signature'],
              //     responseData['user']['id_user']);
              return Right(user);
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


  Future<Map<String, dynamic>?> refreshToken() async {
    final refreshToken =  LocalStorageSingleton.getRefreshToken();
    final idUser =  LocalStorageSingleton.getIdUser();
    if (refreshToken == null) {
      print('No refresh token found');
      return null;
    }

    if (idUser == null) {
      print('No user ID found');
      return null;
    }

    try {
      final response = await DioSingleton.dio.post(
        '/auth/refresh',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({'refreshToken': refreshToken}),
      );
      print('Refresh token response: ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        await LocalStorageSingleton.saveToken(
          responseData['token'],
          responseData['refreshToken'],
          responseData['tokenDSS'],
          responseData['signature'],
          idUser // Usar el idUser almacenado
        );
        return responseData;
      } else {
        print('Token refresh failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during token refresh request: $e');
      return null;
    }
  }

}