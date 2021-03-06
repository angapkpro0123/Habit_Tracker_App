import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/routing/routes.dart';

class CreateYourOwnCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  CreateYourOwnCard({
    required this.title,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: AppColors.cFF2F,
      child: InkWell(
        highlightColor: AppColors.c0000,
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          Get.toNamed(Routes.CREATE_HABIT);
        },
        child: Container(
          padding: EdgeInsets.only(left: 30.0),
          height: 80.0,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 35.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 2.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: AppColors.cFFFF,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
