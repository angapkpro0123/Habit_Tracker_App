import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:habit_tracker/service/database/database_helper.dart';

class CreateHabitScreenController extends GetxController {
  var isSetGoal = false.obs;

  var selectedUnitType = "of times".obs;
  var repeatMode = 0.obs;
  var isGetReminder = true.obs;
  var fillColor = Color(0xFFF53566).obs;
  var habitIcon = Icons.star.obs;
  var reminderTimeList = <TimeOfDay>[].obs;
  var listDateOfMonthlyHabit = <DateTime>[].obs;

  var weekDateList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
  ].obs;

  var weeklyChoiceList = [
    false,
    false,
    false,
    false,
    false,
    false,
    true,
  ].obs;

  var notiTimeChoice = [
    false,
    false,
    false,
    true,
  ].obs;

  final mainScreenController = Get.find<MainScreenController>();

  void initDataAndController(var habit) {
    if (habit != null) {
      // icon
      habitIcon.value = IconData(
        habit.icon,
        fontFamily: 'MaterialIcons',
      );
      // mau
      if (habit is SuggestedHabit) {
        fillColor.value = Color(int.parse(habit.color));
      } else {
        fillColor.value = Color(int.parse(habit.color, radix: 16));
      }
      // bat muc tieu
      isSetGoal.value = habit.isSetGoal;
      // don vi
      selectedUnitType.value = habit.unit;
      // loai lap
      repeatMode.value = habit.repeatMode;
      // ngay trong tuan
      setDailyList(habit.dayOfWeek);
      // so lan trong tuan
      setWeeklyList(habit.timesPerWeek);
      // buoi
      setNotiTimeChoice(habit.timeOfDay);
    }
  }

  @override
  void onClose() {
    // isSetGoal = 1.obs;
    // selectedUnitType = "of times".obs;
    // repeatTypeChoice = 0.obs;
    // isGetReminder = true.obs;
    // fillColor = Color(0xFFF53566).obs;
    // habitIcon = Icons.star.obs;
    // resetWeekDateChoice();
    // resetWeeklyListChoice();
    // resetNotiTimeChoice();
    super.onClose();
  }

  /// [Handle click]
  void onRepeatTypeChoiceClick() {
    if (repeatMode.value == 0) {
      changeWeekdateChoice(7);
    } else {
      changeWeeklyListChoice(6);
    }
  }

  void onDayMonthYearRepeatChoiceClick(int index) {
    changeRepeatTypeIndex(index);

    if (index == 1) {
      resetWeekDateChoice();
    } else if (index == 0) {
      resetWeeklyListChoice();
    }
  }

  /// [==================================================================]

  Future<void> addHabit(String name, String amount) async {
    await DatabaseHelper().insertHabit(
      Habit(
        habitName: name,
        icon: habitIcon.value.codePoint,
        color: fillColor.value.toString().split('(0x')[1].split(')')[0],
        isSetGoal: isSetGoal.value,
        amount: isSetGoal.value ? int.parse(amount) : -1,
        unit: selectedUnitType.value,
        repeatMode: repeatMode.value,
        dayOfWeek: getDailyList(),
        timesPerWeek: getWeeklyList(),
        timeOfDay: getNotiTimeChoice(),
      ),
    );

    await mainScreenController.getAllHabit();
  }

  Future<void> editHabit(String name, int id, String amount) async {
    var habit = Habit(
      habitId: id,
      habitName: name,
      icon: habitIcon.value.codePoint,
      color: fillColor.value.toString().split('(0x')[1].split(')')[0],
      isSetGoal: isSetGoal.value,
      amount: isSetGoal.value ? int.parse(amount) : -1,
      unit: selectedUnitType.value,
      repeatMode: repeatMode.value,
      dayOfWeek: getDailyList(),
      timesPerWeek: getWeeklyList(),
      timeOfDay: getNotiTimeChoice(),
    );
    await DatabaseHelper().updateHabit(habit);

    await mainScreenController.getAllHabit();
  }

  Color getRepeatTypeChoiceColor() {
    if (repeatMode.value == 0) {
      if (weekDateList[7]) {
        return fillColor.value;
      } else
        return Colors.white24;
    } else {
      if (weeklyChoiceList[6]) {
        return fillColor.value;
      } else
        return Colors.white24;
    }
  }

  changeSelectedIndex(bool isOn) {
    isSetGoal.value = isOn;

    // Nếu off thì reset thành giá trị mặc định
    if (!isOn) {
      selectedUnitType = "of times".obs;
    }
  }

  changeSelectedUnitType(String unitType) {
    if (selectedUnitType.value != unitType) {
      selectedUnitType.value = unitType;
    }
  }

  changeRepeatTypeIndex(int index) {
    if (repeatMode.value != index) {
      repeatMode.value = index;
    }
  }

  changeIsGetReminder() {
    isGetReminder.value = !isGetReminder.value;
  }

  changeHabitIcon(IconData? icon) {
    if (habitIcon.value != icon && icon != null) {
      habitIcon.value = icon;
    }
  }

  // Daily list
  changeWeekdateChoice(int index) {
    if (index != 7) {
      weekDateList[index] = !weekDateList[index];

      // Kiếm tra xem ng dùng có bỏ chọn hết các ngày hay không
      bool isEveryday = true;
      int count = 0;
      for (int i = 0; i < 7; i++) {
        if (weekDateList[i]) {
          isEveryday = false;
          count++;
        }
      }
      // Nếu có thì set option everyday thành true và ngược lại
      if (isEveryday) {
        weekDateList[7] = true;
      } else {
        if (count == 7) {
          weekDateList[7] = true;

          // Nếu index = 7 thì reset toàn bộ các ô còn lại
          for (int i = 0; i < 7; i++) {
            weekDateList[i] = false;
          }
          return;
        }
        weekDateList[7] = false;
      }
    } else {
      // Nếu index = 7 thì reset toàn bộ các ô còn lại
      for (int i = 0; i < 7; i++) {
        weekDateList[i] = false;
      }

      weekDateList[7] = true;
    }
  }

  String getDailyList() {
    String a = '';
    if (weekDateList[7]) return a = '2,3,4,5,6,7,8';
    for (int i = 0; i < 7; i++) {
      if (weekDateList[i]) {
        a += (i + 2).toString();
        if (i < 6) a += ',';
      }
    }
    return a;
  }

  setDailyList(String a) {
    List<String> b = a.split(',');
    int count = 0;
    // bật các thứ có trong chuỗi
    for (int i = 0; i < b.length; i++) {
      switch (b[i]) {
        case '2':
          weekDateList[0] = true;
          count++;
          break;
        case '3':
          weekDateList[1] = true;
          count++;
          break;
        case '4':
          weekDateList[2] = true;
          count++;
          break;
        case '5':
          weekDateList[3] = true;
          count++;
          break;
        case '6':
          weekDateList[4] = true;
          count++;
          break;
        case '7':
          weekDateList[5] = true;
          count++;
          break;
        case '8':
          weekDateList[6] = true;
          count++;
          break;
      }
    }

    if (count < 7)
      weekDateList[7] = false;
    else {
      resetWeekDateChoice();
    }
  }

  int getWeeklyList() {
    int temp = 0;
    for (int i = 0; i < 7; i++) {
      if (weeklyChoiceList[i]) temp = i;
    }
    return temp;
  }

  void setWeeklyList(int a) {
    if (a != 6) {
      weeklyChoiceList[a] = true;
      weeklyChoiceList[6] = false;
    }
  }

  String getNotiTimeChoice() {
    String a = '';
    if (notiTimeChoice[3]) return a = '1,2,3';
    for (int i = 0; i < 3; i++) {
      if (notiTimeChoice[i]) {
        a += (i + 1).toString();
        if (i < 2) a += ',';
      }
    }
    return a;
  }

  setNotiTimeChoice(String a) {
    var b = a.split(',');
    var count = 0;
    for (int i = 0; i < b.length; i++) {
      switch (b[i]) {
        case '1':
          notiTimeChoice[0] = true;
          count++;
          break;
        case '2':
          notiTimeChoice[1] = true;
          count++;
          break;
        case '3':
          notiTimeChoice[2] = true;
          count++;
          break;
      }
    }
    if (count < 3)
      notiTimeChoice[3] = false;
    else
      resetNotiTimeChoice();
  }

  resetWeekDateChoice() {
    weekDateList = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
    ].obs;
  }

  resetNotiTimeChoice() {
    notiTimeChoice = [
      false,
      false,
      false,
      true,
    ].obs;
  }

  // Weekly list
  changeWeeklyListChoice(int index) {
    if (index != 6) {
      weeklyChoiceList[index] = !weeklyChoiceList[index];

      // Kiểm tra xemng dùng có bỏ chọn hết các option hay không
      bool isOnceEveryTwoWeeks = true;
      for (int i = 0; i < 6; i++) {
        if (weeklyChoiceList[i]) {
          isOnceEveryTwoWeeks = false;
        }
      }

      // Nếu có thì set tuỳ chọn once every two week thành true và ngược lại
      if (isOnceEveryTwoWeeks) {
        weeklyChoiceList[6] = true;
      } else {
        weeklyChoiceList[6] = false;
        for (int i = 0; i < 6; i++) {
          if (i != index) {
            weeklyChoiceList[i] = false;
          }
        }
      }
    } else {
      // Ngược lại nếu người dùng chọn option là once every two weeks
      for (int i = 0; i < 6; i++) {
        weeklyChoiceList[i] = false;
      }

      weeklyChoiceList[6] = true;
    }
  }

  resetWeeklyListChoice() {
    weeklyChoiceList = [
      false,
      false,
      false,
      false,
      false,
      false,
      true,
    ].obs;
  }

  // Noti time
  changeNotiTime(int index) {
    if (index != 3) {
      notiTimeChoice[index] = !notiTimeChoice[index];

      // Kiếm tra xem ng dùng có chọn khác anytime hay ko
      bool isAnytime = true;
      int count = 0;
      for (int i = 0; i < 3; i++) {
        if (notiTimeChoice[i]) {
          isAnytime = false;
          count++;
        }
      }

      if (isAnytime) {
        notiTimeChoice[3] = true;
      } else {
        if (count == 3) {
          notiTimeChoice[3] = true;

          // Reset các ô chọn morning, afternoon và evening
          for (int i = 0; i < 3; i++) {
            notiTimeChoice[i] = false;
          }
          return;
        }
        notiTimeChoice[3] = false;
      }
    } else {
      notiTimeChoice[3] = true;

      // Reset các ô chọn morning, afternoon và evening
      for (int i = 0; i < 3; i++) {
        notiTimeChoice[i] = false;
      }
    }
  }

  // Thay đổi màu hiển thị trong màn hình
  changeFillColor(Color color) {
    if (color != fillColor.value) {
      fillColor.value = color;
    }
  }
}
