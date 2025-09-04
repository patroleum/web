part of 'session_cubit.dart';


@immutable
class SessionState extends Equatable {
  const SessionState({
    this.sessionStatus = SessionStatus.none,

  });

  final SessionStatus sessionStatus;


  SessionState copyWith({
    SessionStatus? sessionStatus,

  }) =>
      SessionState(
        sessionStatus: sessionStatus ?? this.sessionStatus,

      );

  @override
  List<Object> get props => [
    sessionStatus,     

  ];
}
