import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../create_habit_screen.dart';

class CreateYourOwnCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  CreateYourOwnCard({this.title, this.iconColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Color(0xFF2F313E),
      child: InkWell(
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          Get.to(
            CreateHabitScreen(),
            duration: Duration(milliseconds: 500),
            transition: Transition.fadeIn,
          );
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
                    color: Colors.white,
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
