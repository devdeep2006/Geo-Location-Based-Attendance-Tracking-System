// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';
import 'package:intl/intl.dart';

import 'package:flutter_mobx/flutter_mobx.dart' as mob;
import '../controllers/holiday_page_controller.dart';


DateTime startfrom() {
  DateTime d = DateTime.now();
  DateTime toreturn = DateTime(d.year,d.month-1,d.day+15);
  return toreturn;
}


Widget CheckOutCheckIn(int length,String time,String time1) {
  return
  Padding(
    padding: const EdgeInsets.all(0),
    child:    DecoratedBox(
      decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:  CrossAxisAlignment.start,
          children : [
          ]
        ),
      ),
    ),);
}

class HolidayPageView extends GetView<HolidayPageController> {
   HolidayPageController controller = Get.put(HolidayPageController());
  HolidayPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          title: const Text("Previous Events"),
        ),
        body:Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Obx((){
                          return Text(
                          controller.date.value,
                          style: TextStyle(fontSize: 25),
                        );
                        })
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Obx(() {
                              return Text(controller.day_name.value,
                                                  style: TextStyle(fontSize: 20),);
                            }),
                            SizedBox(width: 5),
                            Obx((){
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:controller.attendanceColor.value,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    controller.attendanceTick.value,
                                    size: 20,
                                  ),
                                ),
                                );
                            
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(right:16),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(style: BorderStyle.solid),borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                                      const Text(
                                        "Working Hours",
                                        style: TextStyle(fontSize: 22),
                                          ),
                                      const SizedBox(height: 8,),
                                      Obx((){
                                        return Text(controller.workinghrscurrent.toString(),style: const TextStyle(fontSize: 20),);
                                      })
                                      ],
                    ),
                  ),
                  )
                ],),
                const SizedBox(height: 2,),
                Container(
                  child: DatePicker(
                    startfrom(),
                    controller: DatePickerController(),
                    onDateChange: (DateTime l ) {
                      int index = (l.day -1)%30+1;
                      controller.currentList = index;
                      controller.changeworkinghrs(index);
                      controller.createList(l);
                      // controller.attendanceTick();
                      // reDraw();
                    },
                    inactiveDates:List.generate(50, (int index) {
                      DateTime date = DateTime.now();
                      return DateTime(date.year,date.month,date.day+index);
                    }),
                    height: 88,
                    width: 70,
                    initialSelectedDate: startfrom(),
                    selectionColor: Color(0xff5495DF),
                    selectedTextColor: Colors.black87,
                    daysCount: 30,
                    )
                ),
                const SizedBox(height: 2,),
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:    DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:// Obx(() {
                       Column(                    
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children : [
                            Row(children:[ 
                            Column(
                            children: [
                              // first one
                              
                              Container(
                                // alignment: controller.tween2.animate(controller.controller1),
                                child: Container(
                                  width: 410,
                                  height:130,
                                  // duration: Duration(seconds: 5),
                                  // transformAlignment: Align(),
                                  margin: const EdgeInsets.only(bottom: 0),
                                  // height: 130,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffebeb),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 9,
                                        offset: Offset(0, 4)
                                        
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 25.0,top: 30,left:25),
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
                                                      color: AppColors.kFoundationPurple300,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Icon(
                                                        Icons.input_rounded,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  10.width,
                                                  Text(
                                                    "Check In",
                                                    style: Get.textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                                  )
                                                ],
                                              ),
                                              10.height,
                                              Padding(
                                                padding: const EdgeInsets.only(left: 35),
                                                child: Obx(
                                                  () {
                                                    return Text(
                                                  controller.checkedIn.value,
                                                  style: Get.textTheme.bodyLarge,
                                                );
                                                  }
                                                )
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
                                                      color: AppColors.kFoundationPurple300,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Icon(
                                                        Icons.input_rounded,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  10.width,
                                                  Text(
                                                    "Check Out",
                                                    style: Get.textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                                  )
                                                ],
                                              ),
                                              10.height,
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20),
                                                child: Obx(
                                                  () {
                                                    return Text(
                                                  controller.checkedOut.value,
                                                  style: Get.textTheme.bodyLarge,
                                                );
                                                  }
                                                )
                                              )
                                            ],
                                          ),
                                          
                                
                                        ],
                                    ),
                                  ),
                                ),
                              ),
                              // firsrt one


                              // Second One
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                width: 410,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffebeb),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 9,
                                      offset: Offset(0, 4)
                                    )
                                  ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0,top: 30,left:25),
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
                                                    color: AppColors.kFoundationPurple300,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Icon(
                                                      Icons.input_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                10.width,
                                                Text(
                                                  "Check In",
                                                  style: Get.textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                                )
                                              ],
                                            ),
                                            10.height,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 35),
                                              child: 
                                              Obx((){
                                                return Text(
                                                controller.checkedIn1.value,
                                                style: Get.textTheme.bodyLarge,
                                              );}),
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
                                                    color: AppColors.kFoundationPurple300,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Icon(
                                                      Icons.input_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                10.width,
                                                Text(
                                                  "Check Out",
                                                  style: Get.textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                                )
                                              ],
                                            ),
                                            10.height,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Obx(
                                                (){
                                                  return Text(
                                                controller.checkedOut1.value,
                                                style: Get.textTheme.bodyLarge,
                                              );
                                                }
                                              )
                                            )
                                          ],
                                        ),
                                        

                                      ],
                                  ),
                                ),
                              ),
                              // Second One

                              //Third One
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                width: 410,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffebeb),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 9,
                                      offset: Offset(0, 4)
                                    )
                                  ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0,top: 30,left:25),
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
                                                    color: AppColors.kFoundationPurple300,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Icon(
                                                      Icons.input_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                10.width,
                                                Text(
                                                  "Check In",
                                                  style: Get.textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                                )
                                              ],
                                            ),
                                            10.height,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 35),
                                              child: 
                                              Obx((){
                                                return Text(
                                                controller.checkedIn2.value,
                                                style: Get.textTheme.bodyLarge,
                                              );}),
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
                                                    color: AppColors.kFoundationPurple300,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Icon(
                                                      Icons.input_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                10.width,
                                                Text(
                                                  "Check Out",
                                                  style: Get.textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                                )
                                              ],
                                            ),
                                            10.height,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Obx(
                                                (){
                                                  return Text(
                                                controller.checkedOut2.value,
                                                style: Get.textTheme.bodyLarge,
                                              );
                                                }
                                              )
                                            )
                                          ],
                                        ),
                                        

                                      ],
                                  ),
                                ),
                              )
                              //Third One


                            ]
                            )]
                            )]
                              
                  ),
                                ),
                )
                // })
              
                
                  ),
          ),
             ] ,


      )
        ));
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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 9,
                                      offset: Offset(0, 4)
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
                          color: AppColors.kFoundationPurple300,
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
                          color: AppColors.kFoundationPurple300,
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
}