part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = HomePageStatus.pure,
    this.videoUrls = const [],
  });

  final HomePageStatus status;
  final List<String> videoUrls;

  HomeState copyWith({
    HomePageStatus? status,
    List<String>? videoUrls,
  }) {
    return HomeState(
      status: status ?? this.status,  
      videoUrls: videoUrls ?? this.videoUrls,
    );
  }

  @override
  List<Object> get props => [
    status,
    videoUrls,
  ];
}
