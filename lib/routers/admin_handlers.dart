import 'package:fluro/fluro.dart';
import 'package:patroleum_dashboard/app/modules/auth/login/login_view.dart';

class AdminHandlers{

  static Handler login = Handler(
    handlerFunc: (context, params) {
      return LoginView();
    }
  );

}