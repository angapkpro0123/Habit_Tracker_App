import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:habit_tracker/service/database/database_helper.dart';

class HabitAllNoteScreenController extends GetxController {
  var loadingState = AllNoteLoadingState.isLoading.obs;

  var listNote = <Diary>[].obs;

  DatabaseHelper databaseHelper = DatabaseHelper();

  /// [Read date data]
  Future<void> getAllNote(int habitId) async {
    listNote.value = await databaseHelper.getAllNote(habitId);
    if (listNote.isEmpty) {
      loadingState.value = AllNoteLoadingState.noDataAvailable;
    } else {
      loadingState.value = AllNoteLoadingState.isLoaded;
    }
  }
}
