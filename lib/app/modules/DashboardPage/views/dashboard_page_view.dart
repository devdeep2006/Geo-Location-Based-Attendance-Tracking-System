import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/data/models/user_data_model.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/app_button.dart';

import '../controllers/dashboard_page_controller.dart';

class DashboardPageView extends GetView<DashboardPageController> {
  const DashboardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: "rootUI",
        init: controller,
        builder: (context) {
          return Scaffold(
            body: FutureBuilder<UserDataModel?>(
                future: AppStorageController.to.asyncCurrentUser,
                builder: (context, snapshot) {
                  // print(snapshot.data?.toJson());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                   else {
                    return Obx(() {
                      return Scaffold(
                        body: IndexedStack(
                          index: controller.currentIndex.value,
                          children: controller.pages,
                        ),
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: AppColors.kFoundationPurple700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          onPressed: controller.onFloatTap,
                          child: Icon(
                            Icons.pin_drop_outlined,
                            color: controller.currentIndex.value == 4 ? const Color.fromARGB(255, 8, 8, 8) : const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                        bottomNavigationBar: AnimatedBottomNavigationBar(
                          icons: const [
                            Icons.home_filled,
                            Icons.calendar_month_rounded,
                            Icons.bar_chart_rounded,
                            Icons.person_3_outlined,
                          ],
                          notchMargin: 7,
                          activeIndex: controller.currentIndex.value,
                          splashRadius: 3,
                          inactiveColor: Colors.black,
                          leftCornerRadius: 35,
                          rightCornerRadius: 35,
                          activeColor: AppColors.kFoundationPurple700,
                          gapLocation: GapLocation.center,
                          notchSmoothness: NotchSmoothness.defaultEdge,
                          backgroundColor: AppColors.kpurpleBackground,
                          onTap: controller.onBottomNavTap,
                        ),
                      );
                    });
                  }
                }),
          );
        });
  }
}