import 'package:flutter/material.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';

class OptionsMenuWidget extends StatefulWidget {
  const OptionsMenuWidget({super.key});

  @override
  State<OptionsMenuWidget> createState() => _OptionsMenuWidgetState();
}

class _OptionsMenuWidgetState extends State<OptionsMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveSingleton.heightCustom(0.01),
              horizontal: ResponsiveSingleton.widthCustom(0.01),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: ResponsiveSingleton.widthCustom(0.01),
                fontWeight: FontWeight.bold,
                color: Colors.black54
              ),
            ),
          ),

          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.04),
            child: ItemMenu(
              title: 'Dashboard',
              icon: Icons.dashboard,
            ),
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.01)
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.04),
            child: ItemMenu(
              title: 'Live',
              icon: Icons.videocam,
              selected: true,
            ),
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.01)
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.04),
            child: ItemMenu(
              title: 'Messages',
              icon: Icons.message,
            ),
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.01)
          ),
          SizedBox(
            height: ResponsiveSingleton.heightCustom(0.04),
            child: ItemMenu(
              title: 'Users',
              icon: Icons.person_sharp,
            ),
          ),

        ],
      ),
    );
  }
}


class ItemMenu extends StatelessWidget {
  const ItemMenu({
    required this.title,
    required this.icon,
    this.selected = false,
    super.key
  });

  final String title;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selected 
          ? Container(
              width: ResponsiveSingleton.widthCustom(0.005),
              decoration: BoxDecoration(
                color: selected ?  Colors.green.shade900 : Colors.grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
            )
          : SizedBox(
              width: ResponsiveSingleton.widthCustom(0.005),
            ),
        SizedBox(
          width: ResponsiveSingleton.widthCustom(0.007)
        ),
        Icon(
          icon,
          color: selected ?  Colors.green.shade900 : Colors.grey,
          size: ResponsiveSingleton.widthCustom(0.02),
        ),
        SizedBox(
          width: ResponsiveSingleton.widthCustom(0.007)
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveSingleton.widthCustom(0.015),
            fontWeight: FontWeight.bold,
            // color: Colors.black54
          ), 
        )
      ],
    );
  }
}