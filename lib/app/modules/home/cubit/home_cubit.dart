import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patroleum_dashboard/data/enums.dart';
import 'package:patroleum_dashboard/provider/internet/rest_provider_dashboard.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> init() async {

    final videosUrls = <String>[];
    // Obtener todos los canales por usuario
    final channels = <String>[
      '1000003\$1\$0\$0',
      '1000005\$1\$0\$0',
      '1000005\$1\$0\$1',
      '1000005\$1\$0\$2',
      '1000005\$1\$0\$3',
    ];

    // Obtener los URLS de los videos por canales
    // await Future.forEach( channels, (channelId) async {
      
    //   final response = await RestDashboardProvider().getVideoUrl(userId: '3', channelId: channelId);
    //   await response.fold(
    //     (error) async{
    //       print(error);
    //       // emit(state.copyWith(sessionStatus: SessionStatus.none)); 

    //     }, (url) async{

    //       print( response );
    //       videosUrls.add(url);

    //     });

    // });

    print(videosUrls);

    emit(
      state.copyWith(
        videoUrls: videosUrls,
        status: HomePageStatus.success,
      )
    );

  }

}
