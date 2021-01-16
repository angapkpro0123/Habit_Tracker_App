import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/view/genaral_screeen.dart';
import 'package:habit_tracker/view/notification_screen.dart';
import 'package:intl/intl.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';

import '../model/habit.dart';
import 'habit_statistic_screen.dart';
import 'login_screen.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  MainScreenController _mainScreenController = Get.put(MainScreenController());

  List<Habit> emptyList = [];

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  AllHabitController allHabitController = Get.put(AllHabitController());

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Color(0xFF2F313E),
      key: _sideMenuKey,
      inverse: false,
      type: SideMenuType.slideNRotate,
      menu: _buildMenu(),
      child: Scaffold(
        backgroundColor: Color(0xFF1E212A),
        appBar: _mainScreenAppBar(),
        body: _mainScreenBody(),
      ),
    );
  }

  /// [Appbar]
  Widget _mainScreenAppBar() {
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            final _state = _sideMenuKey.currentState;
            if (_state.isOpened)
              _state.closeSideMenu();
            else
              _state.openSideMenu();
          },
        ),
      ),
      title: Container(
        child: Text(
          "Today",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black12,
      elevation: 0.0,
    );
  }

  /// [Body]
  Widget _mainScreenBody() {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          Obx(
            // calendar
            () => Container(
              color: Colors.black12,
              padding: const EdgeInsets.only(top: 11, bottom: 11),
              child: FlutterDatePickerTimeline(
                startDate: DateTime.now().subtract(Duration(days: 14)),
                endDate: DateTime.now().add(Duration(days: 14)),
                initialSelectedDate: _mainScreenController.selectedDay.value,
                onSelectedDateChange: (DateTime dateTime) async {
                  allHabitController.flag.value = false;
                  _mainScreenController.changeSelectedDay(dateTime);
                  await allHabitController.getHabitByWeekDate(dateTime.weekday);
                  allHabitController.flag.value = true;
                },
                selectedItemBackgroundColor: Colors.white24,
                selectedItemTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                unselectedItemBackgroundColor: Colors.transparent,
                unselectedItemTextStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      color: Colors.black12,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white24,
                        indicatorColor: Colors.transparent,
                        physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        tabs: [
                          _mainScreenDateTimeTab('All day'),
                          _mainScreenDateTimeTab('Morning'),
                          _mainScreenDateTimeTab('Afternoon'),
                          _mainScreenDateTimeTab('Evening'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          children: <Widget>[
                            allHabitController.flag.value == true
                                ? _listHabit(
                                    allHabitController.listAnytimeHabit)
                                : Container(),
                            allHabitController.flag.value == true
                                ? _listHabit(
                                    allHabitController.listMorningHabit)
                                : Container(),
                            allHabitController.flag.value == true
                                ? _listHabit(
                                    allHabitController.listAfternoonHabit)
                                : Container(),
                            allHabitController.flag.value == true
                                ? _listHabit(
                                    allHabitController.listEveningHabit)
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Widget hiển thị khi ko có habit náo trong database]
  Widget _noneHabitDisplayWidget() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/plant_pot.png",
                width: Get.width * 0.27,
                height: Get.height * 0.27,
              ),
              Text(
                "All tree grown.\nPlant new by clicking \"+\" button",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [Build menu]
  Widget _buildMenu() {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Hello, User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.access_time,
                    "Notification",
                    Color(0xFF11C480),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.settings,
                    "General",
                    Color(0xFF933DFF),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.login,
                    "Login",
                    Color(0xFFFABB37),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Widget cho menu]
  Widget _menuListTile(IconData icon, String title, Color iconColor) {
    return Container(
      transform: Matrix4.translationValues(-15.0, .0, .0),
      width: 250.0,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () {
          if (icon == Icons.access_time) {
            Get.to(
              NotificationScreen(),
              transition: Transition.fadeIn,
            );
          } else if (icon == Icons.settings) {
            Get.to(
              GeneralScreen(),
              transition: Transition.fadeIn,
            );
          } else {
            Get.to(
              LoginScreen(),
              transition: Transition.fadeIn,
            );
          }
        },
        leading: Icon(
          icon,
          size: 30.0,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  /// [Habit list]
  Widget _listHabit(List<Habit> _habitDataList) {
    return _habitDataList.length > 0
        ? Obx(() => ListView.separated(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              itemCount: _habitDataList.length,
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 10),
              itemBuilder: (BuildContext context, int index) {
                if (_habitDataList.length == index + 2)
                  allHabitController.updateListView.value = false;
                int i = allHabitController.listHabitProcess.indexWhere(
                    (e) => e.maThoiQuen == _habitDataList[index].ma);

                if (allHabitController.listHabitProcess[i].ketQua == -1 ||
                    allHabitController.listHabitProcess[i].ketQua ==
                            _habitDataList[index].soLan &&
                        _habitDataList[index].batMucTieu == 0 ||
                    allHabitController.listHabitProcess[i].skip == true) {
                  return swipeRightHabit(_habitDataList[index],
                      allHabitController.listHabitProcess[i]);
                } else {
                  return swipeHabit(_habitDataList[index],
                      allHabitController.listHabitProcess[i]);
                }
              },
            ))
        : _noneHabitDisplayWidget();
  }

  /// [Tab widget]
  Widget _mainScreenDateTimeTab(String title) {
    return Tab(
      child: Container(
        width: Get.width,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget swipeHabit(Habit habit, Process process) {
    return SwipeActionCell(
      backgroundColor: Colors.transparent,
      key: ObjectKey(habit),
      leadingActions: [
        SwipeAction(
          paddingToBoundary: 0,
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'Done',
              ),
            ),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            if (habit.batMucTieu == 0)
              process.ketQua = habit.soLan;
            else
              process.ketQua = -1;

            allHabitController.updateProcess(process);
            print('done');
            setState(() {});
          },
          color: Colors.transparent,
        ),
        if (habit.batMucTieu == 0)
          SwipeAction(
            paddingToBoundary: 0,
            content: Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Center(child: Text('+1')),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              process.ketQua++;
              allHabitController.updateProcess(process);
              print('1');
              setState(() {});
            },
            color: Colors.transparent,
          ),
      ],
      trailingActions: [
        SwipeAction(
          paddingToBoundary: 0,
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
            child: Center(child: Text('Skip')),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.skip = true;
            allHabitController.updateProcess(process);
            print('Skip');
            setState(() {});
          },
          color: Colors.transparent,
        ),
      ],
      child: habitTile(
          habit,
          allHabitController.listHabitProcess.indexWhere(
              (element) => element.maThoiQuen == process.maThoiQuen)),
    );
  }

  Widget swipeRightHabit(Habit habit, Process process) {
    return SwipeActionCell(
      backgroundColor: Colors.transparent,
      key: ObjectKey(habit),
      trailingActions: [
        SwipeAction(
          paddingToBoundary: 0,
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.purple,
            ),
            child: Center(child: Text('Note')),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.skip = true;
            //allHabitController.updateProcess(process);
            print('Note');
            setState(() {});
          },
          color: Colors.transparent,
        ),
        SwipeAction(
          paddingToBoundary: 0,
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.orange,
            ),
            child: Center(child: Text('Undo')),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.skip = false;
            process.ketQua = 0;
            allHabitController.updateProcess(process);
            print('Undo');
            setState(() {});
          },
          color: Colors.transparent,
        ),
      ],
      child: habitTile(
          habit,
          allHabitController.listHabitProcess.indexWhere(
              (element) => element.maThoiQuen == process.maThoiQuen)),
    );
  }

  Widget habitTile(Habit habit, int index) {
    return Obx(() => GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xFF2F313E),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  // icon
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    IconData(habit.icon, fontFamily: 'MaterialIcons'),
                    size: 50,
                    color: allHabitController.listHabitProcess[index].skip ==
                                true ||
                            allHabitController.listHabitProcess[index].ketQua ==
                                -1 ||
                            allHabitController.listHabitProcess[index].ketQua ==
                                    habit.soLan &&
                                habit.soLan != 0
                        ? Colors.grey
                        : Color(
                            int.parse(
                              habit.mau,
                              radix: 16,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  // tên
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.ten,
                          style: TextStyle(
                              fontSize: 22,
                              decoration: allHabitController
                                              .listHabitProcess[index].ketQua ==
                                          -1 ||
                                      allHabitController.listHabitProcess[index]
                                                  .ketQua ==
                                              habit.soLan &&
                                          habit.soLan != 0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                          maxLines: 2,
                        ),
                        if (allHabitController.listHabitProcess[index].skip ==
                            true)
                          Text(
                            'Skiped',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontStyle: FontStyle.italic),
                          )
                      ],
                    ),
                  ),
                ),
                if (habit.batMucTieu == 0)
                  Padding(
                    // process
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          allHabitController.listHabitProcess[index].ketQua
                                  .toString() +
                              '/' +
                              habit.soLan.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(int.parse(habit.mau, radix: 16))),
                        ),
                        Text(
                          habit.donVi,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          onTap: () {
            Get.to(HabitStatisticScreen(), arguments: habit);
          },
        ));
  }
}
