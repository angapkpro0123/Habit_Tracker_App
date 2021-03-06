import 'package:habit_tracker/constants/app_images.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static const googleUserNameKey = "GOOGLE_USER_NAME_KEY";
  static const googleUserPhotoURLKey = "GOOGLE_USER_PHOTO_KEY";
  static const facebookUserNameKey = "FACEBOOK_USER_NAME_KEY";
  static const facebookUserPhotoURLKey = "FACEBOOK_USER_PHOTO_KEY";
  static const morningStartTimeKey = "MORNING_START_TIME_KEY";
  static const afternoonStartTimeKey = "AFTERNOON_START_TIME_KEY";
  static const eveningStartTimeKey = "EVENING_START_TIME_KEY";
  static const startWeekOnKey = "START_WEEK_ON_KEY";
  static const iconBadgeKey = "ICON_BADGE_KEY";
  static const vacationModeKey = "VACATION_MODE_KEY";
  static const unitOfMeasureKey = "UNIT_OF_MEASURE_KEY";
  static const soundKey = "SOUND_KEY";
  static const notificationToneKey = "NOTIFICATION_TONE_KEY";
  static const passcodeLockKey = "PASSCODE_LOCK_KEY";

  static const playStoreId = 'com.android.chrome';
  static const appStoreId = 'com.apple.mobilesafari';

  static const currentLoginType = "CURRENT_LOGIN_KEY";

  
  /// Notification keys
  static const todayPlanKey = "TODAY_PLAN_KEY";
  static const todayPlanSwitchKey = "TODAY_PLAN_KEY";
  static const todayResultKey = "TODAY_RESULT_KEY";
  static const todayResultSwitchKey = "TODAY_RESULT_KEY";
  static const morningPlanKey = "MORNING_PLAN_KEY";
  static const afternoonPlanKey = "AFTERNOON_PLAN_KEY";
  static const eveningPlanKey = "EVENING_PLAN_KEY";

  static final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

}

enum AllNoteLoadingState {
  isLoading,
  noDataAvailable,
  isLoaded,
}

/// Login type
enum LoginType {
  google,
  facebook,
  apple,
}

extension LoginTypeData on LoginType {
  String get loginTypeText {
    switch (this) {
      case LoginType.google:
        return "Sign in with Google";
      case LoginType.facebook:
        return "Sign in ith Facebook";
      case LoginType.apple:
        return "Sign in with Apple";
      default:
        return "Sign in with Apple";
    }
  }

  String get loginTypeIcon {
    switch (this) {
      case LoginType.google:
        return AppImages.icGoogle;
      case LoginType.facebook:
        return AppImages.icFacebook;
      case LoginType.apple:
        return AppImages.icApple;
      default:
        return AppImages.icApple;
    }
  }
}

enum GeneralItemType {
  timeOfDay,
  startWeekOn,
  iconBadge,
  vacationMode,
  unitsOfMeasure,
  sounds,
  notificationTone,
  passCodeLock,
  cleanStateProtocol,
  exportData,
}
