import 'package:fluro/fluro.dart';
import 'package:patroleum_dashboard/app/modules/home/dashboard.dart';

class DashboardHandlers{

  static Handler dashboard = Handler(
    handlerFunc: (context, params) {
      return DashboardView();
    }
  );

}