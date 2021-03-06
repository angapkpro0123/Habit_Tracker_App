import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/challenge_time_line_controller.dart';
import 'package:timelines/timelines.dart';

import 'challenge_time_line_screen_variables.dart';

class ChallengeTimeLineScreen extends StatefulWidget {
  final int tag;
  final String title, challengeAmount, imagePath;

  ChallengeTimeLineScreen({
    Key? key,
    required this.tag,
    required this.title,
    required this.challengeAmount,
    required this.imagePath,
  }) : super(key: key);

  @override
  _ChallengeTimeLineScreenState createState() =>
      _ChallengeTimeLineScreenState();
}

class _ChallengeTimeLineScreenState extends State<ChallengeTimeLineScreen> {
  final _controller = Get.put(ChallengeTimelineScreenController());

  @override
  void initState() {
    super.initState();
    _controller.initChallengeTimelineScreenData(widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      body: Hero(
        tag: widget.tag,
        child: _challengeTimelineScreenBody(),
      ),
    );
  }

  // Widget chứa body của màn hình
  Widget _challengeTimelineScreenBody() {
    return Material(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: challengeTimelineController,
        slivers: [
          _challengeTimelineScreenSliverAppBar(),
          _challengeTimelineScreenSliverBody(),
        ],
      ),
    );
  }

  // AppBar
  Widget _challengeTimelineScreenSliverAppBar() {
    return SliverAppBar(
      expandedHeight: Get.height * 0.3,
      collapsedHeight: Get.height * 0.075,
      backgroundColor: AppColors.cFF2F,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.3 * 0.75),
        child: AppBar(
          backgroundColor: AppColors.c0000,
          elevation: 0.0,
          leading: Text(""),
        ),
      ),
      flexibleSpace: Stack(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              width: Get.width * 0.45,
              height: Get.height * 0.25,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.size.height * 0.3 * 0.35),
                Container(
                  alignment: Alignment.centerLeft,
                  width: Get.width * 0.7,
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "7 days",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.cFFA7,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 120.0,
                          height: 30.0,
                          margin: EdgeInsets.only(top: Get.height * 0.3 * 0.07),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.c3DFF,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            widget.challengeAmount + " joined",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.cFFE2,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            top: Get.height * 0.3 * 0.07,
                            left: 5.0,
                          ),
                          alignment: Alignment.center,
                          width: 70.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: AppColors.cFFF9,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            "WHY",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.cFF2F,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu,
            size: 30.0,
            controller: aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () => _onBackButtonPress(),
            onEndIconPress: () {
              return true;
            },
            duration: Duration(milliseconds: 200),
            startIconColor: AppColors.cFFFF,
            endIconColor: AppColors.cFFFF,
            clockwise: true,
          ),
        ),
        onTap: () => _moveToMangeScreen(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  // Body
  Widget _challengeTimelineScreenSliverBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            height: Get.height * 0.58,
            padding: EdgeInsets.only(bottom: 20.0, top: 15.0),
            child: Timeline.tileBuilder(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              builder: TimelineTileBuilder.fromStyle(
                itemCount: _controller.challengeList.length,
                contentsBuilder: (_, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _controller.dateNamesList[index],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: AppColors.cFFA7,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: Get.height * 0.14,
                              decoration: BoxDecoration(
                                color: AppColors.cFF2F,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  _controller.challengeList[index].icon,
                                  color: _controller
                                      .challengeList[index].iconColor,
                                  size: 40.0,
                                ),
                                title: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _controller.challengeList[index].title,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        _controller
                                            .challengeList[index].description,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.cFFA7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _controller.dateNamesList[
                                  _controller.dateNamesList.length - 1],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: AppColors.cFFA7,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: Get.height * 0.1,
                              decoration: BoxDecoration(
                                color: AppColors.cFF2F,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(
                                    top: Get.height * 0.1 * 0.28,
                                  ),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: AppColors.c1FFF,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: Get.width * 0.08,
              right: Get.width * 0.08,
              top: 3.0,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppColors.cFFF9,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "START CHALLENGE",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.cFF2F,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Handle methods
  bool _onBackButtonPress() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        // Future.delayed(Duration(milliseconds: 200), () {
        //   Get.back();
        // });
        Get.back();
      },
    );

    return true;
  }

  void _moveToMangeScreen() {
    // Future.delayed(Duration(milliseconds: 200), () {
    //   Get.toNamed('/manage_screen');
    // });
    // print('back');
    // Get.back();
  }
}
