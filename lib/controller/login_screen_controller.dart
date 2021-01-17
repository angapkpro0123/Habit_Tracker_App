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
}