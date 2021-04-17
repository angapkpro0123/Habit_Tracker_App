import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';

class GeneralScreen extends StatelessWidget {
  final GeneralScreenController _generalScreenController = Get.put(
    GeneralScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _generalScreenAppBar(),
      body: ListView(
        padding: EdgeInsets.only(top: 40.0),
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          _generalScreenController.variables.generalScreenItems[0],
          _generalScreenSeparateWidget(height: 1, color: Colors.white24),
          _generalScreenController.variables.generalScreenItems[1],
          _generalScreenSeparateWidget(height: 50, isSizedBox: true),
          _generalScreenController.variables.generalScreenItems[2],
          _generalScreenAnnotationWidget(
              content: "See how many habits are due for current part of day"),
          _generalScreenSeparateWidget(height: 50, isSizedBox: true),
          _generalScreenController.variables.generalScreenItems[3],
          _generalScreenAnnotationWidget(
              content: "Hide animation from the main screen and remove sloth"),
          _generalScreenSeparateWidget(height: 50, isSizedBox: true),
          _generalScreenController.variables.generalScreenItems[4],
          _generalScreenAnnotationWidget(
              content:
                  "Enable vacation mode to pause all your habits and keep your stats"),
          _generalScreenSeparateWidget(height: 50, isSizedBox: true),
          _generalScreenController.variables.generalScreenItems[5],
          _generalScreenSeparateWidget(height: 1, color: Colors.white24),
          _generalScreenController.variables.generalScreenItems[6],
          _generalScreenSeparateWidget(height: 1, color: Colors.white24),
          _generalScreenController.variables.generalScreenItems[7],
          _generalScreenSeparateWidget(height: 1, color: Colors.white24),
          _generalScreenController.variables.generalScreenItems[8],
          _generalScreenSeparateWidget(height: 1, color: Colors.white24),
          _generalScreenController.variables.generalScreenItems[9],
          _generalScreenSeparateWidget(height: 40.0, isSizedBox: true),
          _generalScreenController.variables.generalScreenItems[10],
        ],
      ),
    );
  }

  /// [App Bar]
  Widget _generalScreenAppBar() {
    return AppBar(
      title: Text(
        "General",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black12,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Separate widget]
  Widget _generalScreenSeparateWidget({
    double height,
    Color color,
    bool isSizedBox,
  }) {
    return isSizedBox != null
        ? SizedBox(height: height)
        : Container(
            height: 1, color: color == null ? Colors.transparent : color);
  }

  Widget _generalScreenAnnotationWidget({String content}) {
    return Container(
      padding: EdgeInsets.only(left: 17.0, top: 5.0, right: 17.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }
}