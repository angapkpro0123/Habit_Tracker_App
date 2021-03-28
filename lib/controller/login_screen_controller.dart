import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var isLoginOrSignup = 1.obs;
  var isLogninVisible = true.obs;
  var isSignUpVisible = false.obs;

  changeIsLogin(int index) {
    if (isLoginOrSignup.value != index) isLoginOrSignup.value = index;
  }

  changeLoginOrSignUpFormView() {
    isSignUpVisible.value = !isSignUpVisible.value;
    isLogninVisible.value = !isLogninVisible.value;
  }

  void showSignInNotificationDialog({
    BuildContext context,
    String title,
    String text,
  }) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      animType: CoolAlertAnimType.slideInUp,
      title: title,
      text: text,
    );
  }
}
