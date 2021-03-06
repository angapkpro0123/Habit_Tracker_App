import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/habit_category_list_screen_controller.dart';

class HabitCategoryListScreen extends StatefulWidget {
  final String? tag;
  final int? topicId;
  final String? imagePath;

  HabitCategoryListScreen({
    Key? key,
    this.tag,
    this.topicId,
    this.imagePath,
  }) : super(key: key);

  @override
  _HabitCategoryListScreenState createState() =>
      _HabitCategoryListScreenState();
}

class _HabitCategoryListScreenState extends State<HabitCategoryListScreen> {
  HabitCategoryListScreenController _controller = Get.put(
    HabitCategoryListScreenController(),
  );

  late ScrollController _screenScrollController;
  late AnimateIconController _aniController;

  @override
  void initState() {
    super.initState();
    _screenScrollController = ScrollController();
    _aniController = AnimateIconController();
    _controller.getSuggestHabitFromDb(widget.topicId!);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag!,
      child: Scaffold(
        body: _createHabitScreenBody(),
      ),
    );
  }

  /// Widget chứa body của màn hình
  Widget _createHabitScreenBody() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _screenScrollController,
      slivers: [
        _suggestHabitScreenAppBar(),
        _suggestHabitScreenBody(),
      ],
    );
  }

  /// Appbar
  Widget _suggestHabitScreenAppBar() {
    return SliverAppBar(
      expandedHeight: Get.size.height * 0.2,
      collapsedHeight: Get.size.height * 0.075,
      backgroundColor: AppColors.cFF2F,
      pinned: true,
      floating: true,
      flexibleSpace: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0, top: 80.0),
            width: Get.width * 0.55,
            child: Text(
              widget.tag!,
              maxLines: 2,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.5, top: 30.0),
            child: SvgPicture.asset(
              widget.imagePath!,
              fit: BoxFit.contain,
              width: Get.size.width * 0.6,
              height: Get.size.height * 0.22,
            ),
          ),
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.close,
            endIcon: Icons.arrow_back,
            size: 25.0,
            controller: _aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () => _onBackButtonPress(),
            onEndIconPress: () => true,
            duration: Duration(milliseconds: 200),
            startIconColor: AppColors.cFFFF,
            endIconColor: AppColors.cFFFF,
            clockwise: true,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(Get.width, Get.size.height * 0.15),
        child: AppBar(
          leading: Text(""),
          leadingWidth: 0.0,
          backgroundColor: AppColors.c0000,
          elevation: 0.0,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  /// Body
  Widget _suggestHabitScreenBody() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Obx(() => _controller.isLoaded.value
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30.0, left: Get.width * 0.05),
                    alignment: Alignment.topLeft,
                    child: Text(
                      _controller.suggestedHabitList.length.toString() +
                          " habits",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  ...List.generate(_controller.suggestedHabitList.length,
                      (index) {
                    return Container(
                      padding: EdgeInsets.only(top: index == 0 ? 0 : 40.0),
                      child: _controller.suggestHabitCards[index],
                    );
                  }),
                ],
              )
            : Center(child: SpinKitFadingCube(color: AppColors.cFFFF))),
      ),
    );
  }

  bool _onBackButtonPress() {
    Future.delayed(
      Duration(milliseconds: 200),
          () {
        Get.back();
      },
    );

    return true;
  }
}
