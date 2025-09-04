import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:patroleum_dashboard/app/modules/auth/login/login_view.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';
import 'package:patroleum_dashboard/data/enums.dart';
import 'package:patroleum_dashboard/data/local/session_cubit/session_cubit.dart';
import 'package:patroleum_dashboard/routers/router.dart';

void main() {
  Flurorouter.configureRoutes();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ResponsiveSingleton.init(context: context);
      // ResponsiveSingleton.context = context;
    });
  }

  Future<void> initSingleton({required BuildContext buildContext}) async {
    // globalBloc = buildContext.read<GlobalBloc>();
    ResponsiveSingleton.init(context: buildContext);
    ResponsiveSingleton.context = buildContext;
  }

  @override
  Widget build(BuildContext context) {
    initSingleton(buildContext: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (_) => SessionCubit()
          // create: (_) => GetIt.I.get<SessionCubit>(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: '/',
          onGenerateRoute: Flurorouter.router.generator,
          builder: (context, child) {
            return BlocListener<SessionCubit, SessionState>(
              listener: (_, state) {
                switch (state.sessionStatus) {
                  case SessionStatus.closed:
                  case SessionStatus.fail:
                  case SessionStatus.none:
                    _navigatorKey.currentState!.pushReplacementNamed(
                      Flurorouter.loginRoute,
                    );
                    break;
                  case SessionStatus.success:
                     _navigatorKey.currentState!.pushReplacementNamed(
                      Flurorouter.dashboardRoute,
                    );
                    break;
                }
              },
              child: child,
            );
            // return LoginView();
          }),
    );
  }
}
