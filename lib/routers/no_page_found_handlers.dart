import 'package:fluro/fluro.dart';
import 'package:patroleum_dashboard/app/modules/no_page_found/no_page_found.dart';

class NoPageFoundHandlers{

  static Handler noPageFound = Handler(
    handlerFunc: (context, params) {
      return NoPageFoundView();
    }
  );

}