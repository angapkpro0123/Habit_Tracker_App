import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreenController _loginScreenController = LoginScreenController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1E212A),
      appBar: _losginScreenAppBar(),
      body: _loginScreenBody(),
    );
  }

  /// [App Bar]
  Widget _losginScreenAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF1E212A),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Body]
  Widget _loginScreenBody() {
    return Stack(
      children: [
        _loginForm(),
        _signUpForm(),
      ],
    );
  }

  /// [Login form]
  Widget _loginForm() {
    return Obx(
      () => Visibility(
        visible: _loginScreenController.isLogninVisible.value,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Stack(
            children: [
              ListView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/login2.png",
                      fit: BoxFit.contain,
                      width: Get.width * 0.71,
                      height: Get.height * 0.32,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Let's sign you in",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: TextField(
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        hintText: 'Phone, email or username',
                        hintStyle: TextStyle(fontSize: 18.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 18.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xFF1E212A),
                  height: Get.height * 0.13,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?  ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFA7AAB1),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                _loginScreenController
                                    .changeLoginOrSignUpFormView();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      FlatButton(
                        minWidth: Get.width,
                        height: 60.0,
                        onPressed: () {
                          CoolAlert.show(
                            context: _context,
                            type: CoolAlertType.success,
                            animType: CoolAlertAnimType.slideInUp,
                            title: "Sign in sucess",
                            text: "Let's go and make a plan for today",
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xFF1E212A),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [Sign up form]
  Widget _signUpForm() {
    return Obx(
      () => Visibility(
        visible: _loginScreenController.isSignUpVisible.value,
        child: Container(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  bottom: Get.height * 0.15,
                ),
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/register2.png",
                      fit: BoxFit.contain,
                      width: Get.width * 0.71,
                      height: Get.height * 0.32,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Let's join us",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: TextField(
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        hintText: 'Phone, email or username',
                        hintStyle: TextStyle(fontSize: 18.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 18.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 18.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white24,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    child: Text(
                      "Or sign up with",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _signUpBox("images/google.png", "Sign up with Google"),
                  SizedBox(height: 10.0),
                  _signUpBox("images/facebook.png", "Sign up with Facebook"),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xFF1E212A),
                  height: Get.height * 0.13,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?  ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFA7AAB1),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                _loginScreenController
                                    .changeLoginOrSignUpFormView();
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: FlatButton(
                          minWidth: Get.width,
                          height: 60.0,
                          onPressed: () {
                            CoolAlert.show(
                              context: _context,
                              type: CoolAlertType.success,
                              animType: CoolAlertAnimType.slideInUp,
                              title: "Sign up sucess",
                              text: "Let's go and build greatful habits",
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xFF1E212A),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpBox(String imagePath, String title) {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: Color(0xFF2F313E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        onTap: () {},
        leading: Image.asset(
          imagePath,
          width: 35.0,
          height: 35.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
