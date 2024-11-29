import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../controllers/all_employes_page_controller.dart';

class AllEmployesPageView extends GetView<AllEmployesPageController> {
  const AllEmployesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: SafeArea(

        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 160,
                  ),
                  
                  Obx((){
                    return AnimatedContainer(
                      curve: Curves.easeInOutSine,
                      duration: 
                      Duration(seconds: 1),
                      constraints: BoxConstraints(maxHeight: 300,maxWidth: 300),
                      decoration: BoxDecoration(shape: BoxShape.circle,
                      color: controller.colorAnimated.value,
                      ),
                      
                      
                      child://Obx((){
                       ElevatedButton(
                        onPressed: () {},
                        child: Obx((){
                          return Text(controller.buttontext.value,
                          style: TextStyle(fontSize: 40),);
                          }),
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            minimumSize: WidgetStatePropertyAll(Size(300, 300)),
                            shape: WidgetStateProperty.all(CircleBorder()),
                            padding: WidgetStateProperty.all(EdgeInsets.all(20)),
                           backgroundColor: WidgetStatePropertyAll(Colors.transparent)
                          ),
                        )
                        );
                       })
                    
                      // })  
                ],
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Obx((){
                          return SlideAction(
                            // animationDuration: Duration(seconds: 1),
                  text: controller.sliderText.value,
                  textStyle: TextStyle(
                    color: controller.textColor.value,
                    // decoration: TextDecoration.underline,
                    // decorationColor: Colors.red,
                    fontSize: 25,
                  ),
                  height: 75,
                  outerColor: Colors.white,
                  innerColor: controller.arrowColor.value,
                  key: key,
                  elevation: 3,
                  
                        
                  onSubmit: () {
                    controller.canVerifyandVerify();
                  },
                  //sliderRotate: true,
                  // This trailing comma makes auto-formatting nicer for build methods.
                        );
                        })
                      ),
          ],
        )
      ),
    );
  }
}