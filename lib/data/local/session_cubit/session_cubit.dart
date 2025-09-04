
// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:patroleum_dashboard/core/singleton/local_storage_singleton.dart';
import 'package:patroleum_dashboard/data/enums.dart';
import 'package:patroleum_dashboard/provider/internet/rest_provider_login.dart';
import 'package:patroleum_dashboard/services/keep_alive_service.dart';

part 'session_state.dart';

@Injectable()

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionState());

  Future<void> logIn(String email, String password) async {


    await Future.delayed(const Duration(seconds: 3));
    final response = await RestLoginProvider().login(email: email, password: password);
    await response.fold(
      (error) async{
        print(error);
        emit(state.copyWith(sessionStatus: SessionStatus.none)); 

      }, (user) async{
        await LocalStorageSingleton.saveToken(
          user.token,
          user.refreshToken,
          user.tokenDss,
          user.signature,
          user.user.idUser,

        );
        KeepAliveService().start();
        print( response );

        
        emit(state.copyWith(sessionStatus: SessionStatus.success)); 
      });

  }

}
