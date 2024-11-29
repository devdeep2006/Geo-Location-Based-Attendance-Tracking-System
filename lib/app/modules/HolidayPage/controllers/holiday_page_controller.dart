import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/HolidayPage/model/holiday_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/utils/theme/app_colors.dart';


class HolidayPageController extends GetxController with GetSingleTickerProviderStateMixin {
  // var allHolidays = <HolidayModel>[].obs;
  // var isLloading = true.obs;
  var workinghrscurrent = 5 .obs;

  List<List<dynamic>> data_to_build =

[[["4:13PM","9:47PM"],["11:29AM","3:27PM"],["8:58AM","10:53AM"],9],
[["4:03PM","8:12PM"],["12:45AM","3:38PM"],["7:52AM","11:42AM"],8],
[["5:21PM","10:07PM"],["11:32AM","3:35PM"],["9:01AM","10:59AM"],10],
[["4:25PM","7:09PM"],["1:07PM","2:54PM"],["7:59AM","11:48AM"],9],
[["4:18PM","9:53PM"],["11:25AM","3:22PM"],["9:03AM","10:48AM"],8],
[["4:19PM","9:00PM"],["12:51PM","3:03PM"],["8:04AM","11:37AM"],10],
[["5:16PM","10:02PM"],["11:37AM","3:30PM"],["9:05AM","11:04AM"],9],
[["4:23PM","9:59PM"],["11:21AM","3:17PM"],["9:07AM","10:43AM"],10],
[["4:28PM","10:04PM"],["11:16AM","3:12PM"],["9:10AM","10:38AM"],8],
[["4:33PM","10:10PM"],["11:12AM","3:07PM"],["9:12AM","10:33AM"],9],
[["5:52PM","11:25PM"],["11:12AM","2:52PM"],["9:43AM","9:23AM"],7],
[["4:38PM","10:15PM"],["11:08AM","3:02PM"],["9:14AM","10:28AM"],10],
[["5:47PM","11:20PM"],["11:16AM","2:57PM"],["9:41AM","9:28AM"],10],
[["4:43PM","10:21PM"],["11:03AM","2:57PM"],["9:17AM","10:23AM"],8],
[["5:42PM","11:14PM"],["11:20AM","3:02PM"],["9:39AM","9:33AM"],8],
[["4:48PM","10:26PM"],["10:59AM","2:52PM"],["9:19AM","10:18AM"],9],
[["5:02PM","10:32PM"],["11:54AM","3:42PM"],["9:21AM","10:13AM"],11],
[["5:37PM","11:09PM"],["11:24AM","3:07PM"],["9:37AM","9:38AM"],10],
[["5:07PM","10:37PM"],["11:49AM","3:37PM"],["9:24AM","10:08AM"],10],
[["5:37PM","11:09PM"],["11:24AM","3:07PM"],["9:37AM","9:38AM"],10],
[["5:12PM","10:42PM"],["11:45AM","3:32PM"],["9:26AM","10:03AM"],8],
[["5:27PM","10:58PM"],["11:32AM","3:17PM"],["9:32AM","9:48AM"],10],
[["5:17PM","10:48PM"],["11:41AM","3:27PM"],["9:28AM","9:58AM"],10],
[["5:32PM","11:04PM"],["11:28AM","3:12PM"],["9:35AM","9:43AM"],8],
[["5:22PM","10:53PM"],["11:36AM","3:22PM"],["9:30AM","9:53AM"],8],
[["4:25PM","7:09PM"],["1:07PM","2:54PM"],["7:59AM","11:48AM"],9],
[["5:27PM","10:58PM"],["11:32AM","3:17PM"],["9:32AM","9:48AM"],10],
[["5:22PM","10:53PM"],["11:36AM","3:22PM"],["9:30AM","9:53AM"],8],
[["5:32PM","11:04PM"],["11:28AM","3:12PM"],["9:35AM","9:43AM"],8],
[["5:12PM","10:42PM"],["11:45AM","3:32PM"],["9:26AM","10:03AM"],8],
[["5:37PM","11:09PM"],["11:24AM","3:07PM"],["9:37AM","9:38AM"],10],
[["5:02PM","10:32PM"],["11:54AM","3:42PM"],["9:21AM","10:13AM"],11],
[["5:42PM","11:14PM"],["11:20AM","3:02PM"],["9:39AM","9:33AM"],8],
[["4:48PM","10:26PM"],["10:59AM","2:52PM"],["9:19AM","10:18AM"],9],
[["5:47PM","11:20PM"],["11:16AM","2:57PM"],["9:41AM","9:28AM"],10],
[["4:43PM","10:21PM"],["11:03AM","2:57PM"],["9:17AM","10:23AM"],8],
[["5:52PM","11:25PM"],["11:12AM","2:52PM"],["9:43AM","9:23AM"],8],
[["4:38PM","10:15PM"],["11:08AM","3:02PM"],["9:14AM","10:28AM"],10],
];

  late final AnimationController controller1;
  late final AlignmentGeometryTween tween2;
  late final Animation<Offset> offsetAnimation;

  var currentList = 0;
  var checkedIn = "".obs;
  var checkedOut = "".obs;
  var checkedIn1 = "".obs;
  var checkedOut1 = "".obs;
  var checkedIn2 = "".obs;
  var checkedOut2 = "".obs;
  var attendanceTick = Icons.check.obs;
  var attendanceColor = Colors.redAccent.shade200.obs;

  var initi = 0.0.obs;


  RxList<Widget> nowWidgetList = <Widget>[].obs;
                    
  var date = "".obs;
  var day_name = "".obs;

  changeworkinghrs(int index) {
    var day = data_to_build[currentList];
    workinghrscurrent.value = day[day.length-1];
    initi.value = 365.5;
    // initi2.value = 130;
    changeattendanceTick();
  }

  changeattendanceTick() {
    if (workinghrscurrent.value > 8) {
      attendanceTick.value = Icons.check;
      attendanceColor.value = Colors.greenAccent.shade200;
    }
    else {
      attendanceTick.value = Icons.close;
      attendanceColor.value = Colors.red.shade300;
    }
  }


  String monthreturn(int monthnumber) {
    if (monthnumber == 8) {
      return "Aug";
    }
    return "Sep";
  }

  createList(DateTime dayhere){
      var day = data_to_build[currentList];
      var currentcard = day[0];
      var currentcard1 = day[1];
      var currentcard2 = day[2];
      checkedIn.value = currentcard[0];
      checkedOut.value = currentcard[1];
      checkedIn1.value = currentcard1[0];
      checkedOut1.value = currentcard1[1];
      checkedIn2.value = currentcard2[0];
      checkedOut2.value = currentcard2[1];
      // print(dayhere.toMMOnly);
      date.value = dayhere.day.toString() + " " + monthreturn(dayhere.month) + " 2024";
      // date.value = dayhere.toDDMMYYYY;
      day_name.value = dayhere.toWEEKDAY;
  }

  @override
  void onInit() {
    createList(DateTime.now());
    super.onInit();
    controller1 = AnimationController(
    duration: Duration(seconds: 5),
    vsync: this
    );
    tween2 = AlignmentGeometryTween(
      begin: Alignment.centerLeft,
      end:Alignment.center
    );
    offsetAnimation = Tween<Offset>(begin: Offset(1,0),end: Offset.zero).animate(CurvedAnimation(parent: controller1, curve: Curves.bounceIn));
    controller1.forward();
  }

  @override
  void onReady() {
    super.onReady();
    // getAllHoliday();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void getAllHoliday() {
  //   if (!isLloading.value) {
  //     isLloading.value = true;
  //   }
  //   ApiController.to
  //       .callGETAPI(
  //     url: APIUrlsService.to.allHolidayByCompanyID(
  //       AppStorageController.to.currentUser!.companyID!,
  //     ),
  //   )
  //       .then((resp) {
  //     if (resp != null && resp is List<dynamic>) {
  //       allHolidays.clear();
  //       allHolidays.addAll(
  //         resp.map((e) => HolidayModel.fromJson(e)).toList(),
  //       );
  //     } else {
  //       showErrorSnack((resp['errorMsg'] ?? resp).toString());
  //     }
  //     isLloading.value = false;
  //   }).catchError((e) {
  //     isLloading.value = false;
  //     showErrorSnack((e).toString());
  //   });
  // }

  // Future<void> addHoliday(DateTime? selectedDate, String? label) async {
  //   if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) {
  //     final resp = await ApiController.to.callPOSTAPI(
  //       url: APIUrlsService.to.createHoliday,
  //       body: {
  //         "userID": AppStorageController.to.currentUser?.userID,
  //         "companyID": AppStorageController.to.currentUser?.companyID,
  //         "label": label,
  //         "date": selectedDate!.toYYYMMDD, //yyyy-MM-dd
  //       },
  //     );
  //     if (resp is Map<String, dynamic>) {
  //       if (resp['status']) {
  //         closeDialogs();
  //         getAllHoliday();
  //       } else {
  //         showErrorSnack(resp.toString());
  //       }
  //     } else {
  //       showErrorSnack(resp.toString());
  //     }
  //   } else {
  //     showErrorSnack("Super Admin can only add this");
  //   }
  // }

  // deleteHoliday(HolidayModel holiday) {
  //   if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) {
  //     Get.defaultDialog(
  //       title: "Delete",
  //       content: const Text("Are you sure you want to delete this?"),
  //       textCancel: "No",
  //       onCancel: closeDialogs,
  //       textConfirm: "Yes",
  //       onConfirm: () async {
  //         final resp = await ApiController.to.callPOSTAPI(
  //           url: APIUrlsService.to.deleteHoliday,
  //           body: {
  //             "userID": AppStorageController.to.currentUser?.userID,
  //             "companyID": AppStorageController.to.currentUser?.companyID,
  //             "holidayID": holiday.id,
  //           },
  //         );
  //         if (resp is Map<String, dynamic>) {
  //           if (resp['status']) {
  //             closeDialogs();
  //             getAllHoliday();
  //           } else {
  //             showErrorSnack(resp.toString());
  //           }
  //         } else {
  //           showErrorSnack(resp.toString());
  //         }
  //       },
  //     );
  //   } else {
  //     showErrorSnack("Super Admin can only delete this");
  //   }
  // }



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
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: Offset(0, 8),
            
          )
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
                          color: AppColors.kFoundationPurple100,
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
                          color: AppColors.kFoundationPurple100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            iconData1,
                            size: 20,
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
