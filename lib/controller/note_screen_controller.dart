import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:intl/intl.dart';

class NoteScreenController extends GetxController {
  var habitId = 1.obs;
  var initTextFieldData = "".obs;

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  void checkAndUpdateHabitId(dynamic value) {
    if (value != null) {
      updateHabitId(value);
    }
  }

  updateHabitId(int id) {
    habitId.value = id;
  }

  Future<void> readDataForTextController() async {
    await databaseHelper
        .selectHabitNote(habitId.value)
        .then((value) {
      if (value.length != 0) {
        initTextFieldData.value = value[0]['noi_dung'];
        print(initTextFieldData.value);
      }
    }).catchError((err) => debugPrint(err.toString()));
  }

  void saveHabitNoteData(String noteContent) async {
    await databaseHelper
        .selectHabitNote(habitId.value)
        .then((value) {
      if (value.length == 0) {
        databaseHelper.insertHabitNote(
          Diary(
            maThoiQuen: habitId.value,
            ngay: DateFormat("dd MM yyyy").format(
              DateTime.now(),
            ),
            noiDung: noteContent,
          ),
        );
        Get.back();
        return;
      } else {
        /// [Xét trường hợp nếu ng dùng sửa các noter cũ]
        for (int i = 0; i < value.length - 1; i++) {
          databaseHelper.updateHabitNoteData(
            Diary(
              maThoiQuen: habitId.value,
              ngay: value[i]['ngay'],
              noiDung: noteContent,
            ),
          );
          Get.back();
        }

        /// [Xét trường hợp cho note gần nhất]
        if (value[value.length - 1]['ngay'] ==
            DateFormat("dd MM yyyy").format(
              DateTime.now(),
            )) {
          databaseHelper.updateHabitNoteData(
            Diary(
              maThoiQuen: habitId.value,
              ngay: DateFormat("dd MM yyyy").format(
                DateTime.now(),
              ),
              noiDung: noteContent,
            ),
          );
          Get.back();
        } else if (value[value.length - 1]['ngay'] !=
            DateFormat("dd MM yyyy").format(
              DateTime.now(),
            )) {
          databaseHelper.insertHabitNote(
            Diary(
              maThoiQuen: habitId.value,
              ngay: DateFormat("dd MM yyyy").format(
                DateTime.now(),
              ),
              noiDung: noteContent,
            ),
          );
          Get.back();
        }
      }
    });
  }
}
