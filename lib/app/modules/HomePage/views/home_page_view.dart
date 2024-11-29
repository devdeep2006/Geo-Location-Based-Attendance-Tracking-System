import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/HomePage/model/user_activity_model.dart';
import 'package:hr_application/app/modules/HomePage/views/user_activity_view.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/horizontal_date.dart';
import 'package:hr_application/widgets/swipebutton/swipe_button.dart';
import 'package:intl/intl.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //? User Profile
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(minRadius: 25, backgroundImage: AssetImage("assets/red2_2.png"),backgroundColor: Colors.white,),
                16.width,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Devdeep Mukherjee"
                    ),
                    Text(
                      "5-11,Malviya Nagar,Delhi-110076",
                      style: Get.textTheme.bodyLarge,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined),
                )
              ],
            ),
          ),
          
          12.height,
          //? Today Attendence Text
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text("Today Attendence", style: Get.textTheme.headlineSmall),
                16.width,
                if (AppStorageController.to.currentUser?.roleType ==
                        UserRoleType.admin ||
                    AppStorageController.to.currentUser?.roleType ==
                        UserRoleType.manager ||
                    AppStorageController.to.currentUser?.roleType ==
                        UserRoleType.superAdmin) ...[
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.HOME_ANALYTICS);
                    },
                    icon: Icon(Icons.analytics_outlined,),
                  ),
                  20.width,
                ],
              
                    // controller.attendenceLoading.value
                    //     ? const SizedBox(
                    //         width: 10,
                    //         height: 10,
                    //         child: CircularProgressIndicator(
                    //           color: Color.fromARGB(255, 164, 126, 219),
                    //           strokeWidth: 1.5,
                    //         ),
                    //       )
                    //     : const SizedBox(),
              ],
            ),
          ),
          8.height,
          //? Check In && Check Out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                     _buildCheckInOutCard(
                      Icons.login,
                      "Check In",
                      "9:30 AM",
                      "On Time"
                      //controller.userActivityModel.value?.checkIn?.msg ?? '',
                    ),
                  
                ),
                10.width,
                Expanded(
                  child: 
                       _buildCheckInOutCard(
                        Icons.logout,
                        "Check Out",
                        "06:30 PM",
                        "Back Home"
                      ),
                ),
              ],
            ),
          ),
          8.height,
          //? Break Time && Total Days
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(child: _buildCheckInOutCard(Icons.free_breakfast_outlined, "Break Time", "00:20 min", "Avg Time 30min")),
                Expanded(
                  child:  _buildCheckInOutCard(
                        Icons.free_breakfast_outlined,
                        "Break Time",
                        "1:30 Hr",
                        "Avg Interval: 30min",    
                      ),
                ),
                10.width,
                Expanded(
                  child: _buildCheckInOutCard(
                    Icons.calendar_today_outlined,
                    "Total Hours",
                    "09 Hours",
                    "",
                  ),
                ),
              ],
            ),
          ),
          //? Total Working Time
          
          25.height,
          //? Your Activity View All
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Your Activity Status", style: Get.textTheme.headlineSmall),
          ),
          20.height,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:UserActivityView(
                  userActivityModel: controller.userActivityModel.value,
                ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(bottom: 0,top: 16,right: 16,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                5.width,
                Expanded(
                  child: 
                       _buildCheckInOutCard1(
                        Icons.login,
                        "Check In",
                        "06:00 PM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',
                        Icons.logout,
                        "Check Out",
                        "06:30 PM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',
                       )
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 16,bottom: 16,left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                5.width,
                Expanded(
                  child: 
                       _buildCheckInOutCard1(
                        Icons.login,
                        "Check In",
                        "1:00 PM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',
                        Icons.logout,
                        "Check Out",
                        "05:30 PM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',
                       )
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 0,bottom: 16,left: 14,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                10.width,
                Expanded(
                  child: 

                       _buildCheckInOutCard1(
                        Icons.input_rounded,
                        "Check In",
                        "09:30 AM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',
                        Icons.input_rounded,
                        "Check Out",
                        "12:00 PM",
                        controller.userActivityModel.value?.outTime?.msg ?? '',

                      )
                ),
              ],
            ),
          ),
        ],
        
        
        
      ),
    );
  }

  _buildCheckInOutCard(
    IconData iconData,
    String title,
    String time,
    String description,
  ) {
    return DecoratedBox(
      
      decoration: kBoxDecoration,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      iconData,
                      size: 20,
                    ),
                  ),
                ),
                10.width,
                Text(
                  title,
                  style: Get.textTheme.bodyLarge,
                )
              ],
            ),
            8.height,
            Text(
              time,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              description,
              style: Get.textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
_buildCheckInOutCard1(
    IconData iconData,
    String title,
    String time,
    String description,
    IconData iconData1,
    String title1,
    String time1,
    String description1,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      height: 130,
      decoration: BoxDecoration(
        color: Color(0xffffebeb),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.kGrey300.withOpacity(.2),
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: 2,
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0,top: 30,left: 20),
        child: Row(
          //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.kFoundationPurple300
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            iconData,
                            size: 20,
                            color:Color.fromARGB(255, 0, 0, 0)
                            
                          ),
                        ),
                      ),
                      10.width,
                      Text(
                        title,
                        style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
                      )
                    ],
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      time,
                      style: Get.textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
              60.width,
              Column(
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.kFoundationPurple300
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            iconData1,
                            size: 20,
                            color:Color.fromARGB(255, 0, 0, 0)
                          ),
                        ),
                      ),
                      10.width,
                      Text(
                        title1,
                        style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
                      )
                    ],
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      time1,
                      style: Get.textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
              

            ],
        ),
      ),
    );
  }
