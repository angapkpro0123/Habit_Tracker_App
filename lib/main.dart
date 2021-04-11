import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/manage_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'constants/app_constant.dart';

void main() => initializeDateFormatting().then(
      (_) => runApp(
        GetMaterialApp(
          theme: ThemeData.dark(),
          home: IntroScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        Get.offAll(ManageScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "${AppConstant.imagePath}habit_tracker.png",
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
