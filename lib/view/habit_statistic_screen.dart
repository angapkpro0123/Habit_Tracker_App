import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_images.dart';
import 'package:habit_tracker/controller/habit_statistic_controller.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/widgets/custom_confirm_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitStatisticScreen extends StatefulWidget {
  @override
  _HabitStatisticScreenState createState() => _HabitStatisticScreenState();
}

class _HabitStatisticScreenState extends State<HabitStatisticScreen> {
  AnimateIconController _controller = AnimateIconController();
  HabitStatisticController _habitStatisticController =
      Get.put(HabitStatisticController());

  final mainScreenController = Get.find<MainScreenController>();

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null)
      _habitStatisticController.habit.value = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      appBar: _habitStatisticScreenAppBar(),
      body: _habitStatisticScreenBody(),
    );
  }

  /// [Appbar]
  PreferredSizeWidget _habitStatisticScreenAppBar() {
    return AppBar(
      leading: Container(
        transform: Matrix4.translationValues(-3.0, -3.2, 0.0),
        child: IconButton(
          icon: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu_rounded,
            size: 30.0,
            controller: _controller,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () => _onBackButtonPress(),
            onEndIconPress: () => true,
            duration: Duration(milliseconds: 200),
            startIconColor: AppColors.cFFFF,
            endIconColor: AppColors.cFFFF,
            clockwise: true,
          ),
          onPressed: null,
        ),
      ),
      actions: [
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          offset: Offset(0.0, 58.0),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _moveToEditHabitScreen(),
                    borderRadius: BorderRadius.circular(90.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 58.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Obx(
                    () => InkWell(
                      onTap: () => _onPopMenuPauseItemPress(),
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 58.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        child: Icon(
                          _habitStatisticController.isResumeHabit.value == true
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 25.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 50.0,
                  child: InkWell(
                    onTap: () => _showDeleteDialog(),
                    borderRadius: BorderRadius.circular(90.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 58.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _moveToHabitAllNoteScreen(),
                    borderRadius: BorderRadius.circular(90.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 58.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      child: Icon(
                        Icons.event_note,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
      backgroundColor: AppColors.c0000,
      elevation: 0.0,
    );
  }

  /// [Body]
  Widget _habitStatisticScreenBody() {
    return ListView(
      padding: EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 20.0,
        top: 10.0,
      ),
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Obx(
          () => Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    IconData(
                      _habitStatisticController.habit.value.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    size: 50.0,
                    color: Color(
                      int.parse(
                        _habitStatisticController.habit.value.color,
                        radix: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      _habitStatisticController.habit.value.habitName,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible:
              _habitStatisticController.habit.value.amount == 0 ? false : true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 80.0, top: 15.0),
                child: Obx(
                  () => Row(
                    children: [
                      Text(
                        _habitStatisticController.finishedAmount.value
                            .toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFFFE,
                        ),
                      ),
                      Text(
                        "/" +
                            _habitStatisticController.habit.value.amount
                                .toString() +
                            " ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFF21.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        _habitStatisticController.habit.value.unit!,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFFA7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 80.0),
                child: Obx(
                  () => FAProgressBar(
                    currentValue: 0,
                    maxValue: _habitStatisticController.habit.value.amount!,
                    size: 5,
                    backgroundColor: AppColors.cFF2F,
                    progressColor: AppColors.cFFFE,
                    displayTextStyle: TextStyle(color: AppColors.c0000),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, left: 80.0),
          child: Row(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Repeat:",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.cFFA7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _habitStatisticController.habit.value.repeatMode == 0
                          ? 'Daily'
                          : 'Weekly',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: (Get.width - 104) * 0.45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Remind:",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.cFFA7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _habitStatisticController.remindTime.value,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: AppColors.cFF2F,
            borderRadius: BorderRadius.circular(30.0),
          ),
          height: Get.height * 0.55,
          child: TableCalendar(
            locale: 'vi_VN',
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.cFFFE,
              ),
            ),
            availableGestures: AvailableGestures.none,
            // headerVisible: false,
            focusedDay: DateTime.now(),
            firstDay: DateTime.now(),
            lastDay: DateTime.now(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            color: AppColors.cFF0A,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.centerRight,
                transform:
                    Matrix4.translationValues(Get.width * 0.02, 0.0, 0.0),
                child: ClipRRect(
                  child: SvgPicture.asset(
                    AppImages.imgMedal,
                    fit: BoxFit.contain,
                    height: Get.height * 0.3 * 0.9,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: Get.height * 0.3 * 0.18,
                  left: 26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _habitStatisticController.currentStreak.value + " days",
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Your current streak",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.cFFA7,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.icTrophy,
                            width: 30.0,
                            height: 30.0,
                            color: AppColors.cFFC7,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              _habitStatisticController.longestStreak.value +
                                  " days",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Your longest streak",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.cFFA7,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _completeRateAndTotalTimesWidget(
                icon: Icons.show_chart,
                title: _habitStatisticController.completeRate,
                description: "Habit complete rate",
                iconColor: AppColors.cFFFE,
              ),
              _completeRateAndTotalTimesWidget(
                icon: Icons.check,
                title: _habitStatisticController.totalTimeComplete,
                description: "Total time completed",
                iconColor: AppColors.cFF11,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _completeRateAndTotalTimesWidget(
      {required IconData icon,
      required RxString title,
      required String description,
      required Color iconColor}) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: Get.width * 0.45,
        height: Get.height * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.cFF2F,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(
                icon,
                size: 30.0,
                color: iconColor,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              title.value + (icon == Icons.show_chart ? " %" : ""),
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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

  /// [Pause dialog]
  void _onPopMenuPauseItemPress() {
    if (_habitStatisticController.isResumeHabit.value) {
      _showPauseDialog();
    } else {
      _habitStatisticController.changeIsResumeHabit();
    }
  }

  void _showPauseDialog() async {
    showDialog(
      context: context,
      builder: (_) {
        return CustomConfirmDialog(
          title:
              "Paused a habit? It's still on your schedule and can be resued when you're ready",
          onNegativeButtonTap: () {
            Navigator.pop(context);
          },
          negativeButtonText: 'Got it',
          positiveButtonText: '',
        );
      },
    );
  }

  void _onPauseItemButtonPressed() {
    _habitStatisticController.changeIsResumeHabit();
    Get.back();
  }

  /// [Delete dialog]
  void _showDeleteDialog() async {
    Dialog deleteDialog = Dialog(
      backgroundColor: AppColors.cFF2F,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //this right here
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.2 * 0.1),
              child: Text(
                "Delete habit?",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).marginOnly(bottom: 12.0),
            Container(
              child: ListTile(
                onTap: () => onDeleteHabitButtonPressed(),
                leading: Icon(
                  Icons.restore_outlined,
                  size: 20.0,
                  color: AppColors.cFFFE,
                ),
                title: Text(
                  "Clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: AppColors.cFF9E,
            ),
            Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                onTap: () => onDeleteHabitButtonPressed(),
                leading: Icon(
                  Icons.auto_delete,
                  size: 20.0,
                  color: AppColors.cFFF5,
                ),
                title: Text(
                  "Delete habit and clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => deleteDialog,
    );
  }

  void onDeleteHabitButtonPressed() {
    mainScreenController.deleteHabit(_habitStatisticController.habit.value);
    Get.close(3);
  }

  /// [Move to habit all note screen]
  void _moveToHabitAllNoteScreen() {
    Get.back();
    Get.toNamed(
      Routes.ALL_NOTE,
      arguments: _habitStatisticController.habit.value.habitId,
    );
  }

  /// [Move to edit habit screen]
  void _moveToEditHabitScreen() {
    Get.back();
    Get.toNamed(
      Routes.EDIT_HABIT,
      arguments: _habitStatisticController.habit.value,
    );
  }
}
