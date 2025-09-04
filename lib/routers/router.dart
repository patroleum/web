import 'package:fluro/fluro.dart';
import 'package:patroleum_dashboard/routers/admin_handlers.dart';
import 'package:patroleum_dashboard/routers/dashboard_handlers.dart';
import 'package:patroleum_dashboard/routers/no_page_found_handlers.dart';

class Flurorouter {

  static final  router = FluroRouter();

  static String rootRoute = '/';

  // AuthRouter
  static String loginRoute    = '/auth/login';
  // static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';

  static void configureRoutes() {
    router.define (rootRoute, handler: AdminHandlers.login);
    router.define(loginRoute, handler: AdminHandlers.login);

    router.define(dashboardRoute, handler: DashboardHandlers.dashboard);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }

}