import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patroleum_dashboard/app/modules/home/cubit/home_cubit.dart';
import 'package:patroleum_dashboard/app/modules/home/widgets/menu_dashboard.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';
import 'package:patroleum_dashboard/data/enums.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {

            if (state.status == HomePageStatus.pure) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == HomePageStatus.error) {
              return const Center(
                child: Text('Error'),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    ResponsiveSingleton.widthCustom(0.005),
                  ),
                  child: Container(
                    width: ResponsiveSingleton.widthCustom(0.2),
                    height: ResponsiveSingleton.heightCustom(1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MenuDashboard(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    ResponsiveSingleton.widthCustom(0.005),
                  ),
                  child: Container(
                    width: ResponsiveSingleton.widthCustom(0.78),
                    height: ResponsiveSingleton.heightCustom(1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ResponsiveSingleton.heightCustom(0.15),
                        ),
                        Container(
                          width: ResponsiveSingleton.widthCustom(0.9),
                          height: ResponsiveSingleton.heightCustom(0.8),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: ResponsiveSingleton.widthCustom(
                                            0.37),
                                        height:
                                            ResponsiveSingleton.heightCustom(
                                                0.38),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        width: ResponsiveSingleton.widthCustom(
                                            0.37),
                                        height:
                                            ResponsiveSingleton.heightCustom(
                                                0.38),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: ResponsiveSingleton.widthCustom(
                                            0.37),
                                        height:
                                            ResponsiveSingleton.heightCustom(
                                                0.38),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        width: ResponsiveSingleton.widthCustom(
                                            0.37),
                                        height:
                                            ResponsiveSingleton.heightCustom(
                                                0.38),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ]),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
