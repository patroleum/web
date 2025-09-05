import 'package:flutter/material.dart';
import 'package:patroleum_dashboard/app/modules/home/widgets/options_menu.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveSingleton.heightCustom( 0.025 ),
          ),
          child: Image.asset(
            'assets/images/patroleum.png',
            width: ResponsiveSingleton.heightCustom( 0.2 ),
            // height: ResponsiveSingleton.heightCustom( 0.7 ),
          ),
        ),

        Expanded(child: OptionsMenuWidget()),

      ],
    );
  }
}