import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:revision/sqflite/database/notehelpers.dart';
//import 'package:revision/sqflite/model/notemodel.dart';
import 'package:revision/sqflite/screens/add_task_form.dart';
import 'package:revision/sqflite/services/them_services.dart';
import 'package:revision/sqflite/utils/themes.dart';
import 'package:revision/sqflite/utils/widgets/alert_dailoges.dart';
import 'package:revision/sqflite/utils/widgets/elevated.dart';
import 'package:revision/sqflite/utils/widgets/text_tile.dart';

import '../controller/notecontroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();

  runApp(GetMaterialApp(
    themeMode: ThemeServices().theme,
    // themeMode: change = true ? ThemeMode.light : th,
    darkTheme: ThemeData(
      backgroundColor: darkbg,
      primaryColor: darks,
      brightness: Brightness.dark,
    ),
    theme: ThemeData(
        backgroundColor: primarybg,
        primaryColor: primary,
        brightness: Brightness.light),
    home: NotePage(),
  ));
}

class NotePage extends StatefulWidget {
  NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  DateTime _selecteddate = DateTime.now();
  final NoteController _noteController = Get.put(NoteController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTask(),
          _datePicker(),
          _showNotes(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: primary,
      // backgroundColor: ,
      title: Text(
        "Tasks",
        style: headingStyle2,
      ),
      actions: [
        IconButton(
            onPressed: () {
              ThemeServices().switchIcon();
            },
            icon: Icon(Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined))
      ],
    );
  }

  _addTask() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
          Elevated(
              label: '+ Add Task',
              onTap: () {
                Get.to(TaskForm());
                _noteController.updateNote();
              }),
        ],
      ),
    );
  }

  _datePicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: DatePicker(
          DateTime.now(),
          height: 90,
          width: 55,
          selectionColor: primary,
          dayTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
          dateTextStyle:
              GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20),
          monthTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
          initialSelectedDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              _selecteddate = date;
            });
          },
        ),
      ),
    );
  }

  showEmpty() {
    return Center(
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  _showNotes() {
    return Expanded(child: Obx(() {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _noteController.noteList.length,
        itemBuilder: (context, index) {
          final task = _noteController.noteList[index];
          print(task);
          if (task.repeat == "Daily") {
            // DateTime date = DateFormat.jm().parse(task.startTime.toString());
            // var mytime = DateFormat('HH:mm').format(date);
            // print(mytime);
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDailoges(
                                title: 'Delete',
                                note: 'Do you want to delete this task',
                                onPressyes: () async {
                                  Get.back();
                                  await _noteController.deleteNote(
                                      _noteController.noteList[index]);
                                  context.showSuccessBar(
                                      icon: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                      position: FlashPosition.bottom,
                                      content: Text('Deleted'));
                                  _noteController.updateNote();
                                },
                                onPresscancel: () {
                                  Get.back();
                                  _noteController.updateNote();
                                },
                              );
                            },
                          );
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                        backgroundColor: red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ]),
                    startActionPane: task.isCompleted == 0
                        ? ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDailoges(
                                        onPressyes: () {
                                          Get.back();
                                          _noteController.isCompleted(task.id!);
                                          _noteController.updateNote();
                                        },
                                        onPresscancel: () {
                                          Get.back();
                                        },
                                        title: 'Complete',
                                        note: 'Do you completed the Task');
                                  },
                                );
                              },
                              icon: Icons.check,
                              label: 'Completed',
                              backgroundColor: blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ])
                        : null,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskTile(_noteController.noteList[index])),
                  )),
                ));
          }
          if (task.date == DateFormat.yMd().format(_selecteddate)) {
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDailoges(
                                title: 'Delete',
                                note: 'Do you want to delete this task',
                                onPressyes: () async {
                                  Get.back();
                                  await _noteController.deleteNote(
                                      _noteController.noteList[index]);
                                  context.showSuccessBar(
                                      icon: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                      position: FlashPosition.bottom,
                                      content: Text('Deleted'));
                                  _noteController.updateNote();
                                },
                                onPresscancel: () {
                                  Get.back();
                                  _noteController.updateNote();
                                },
                              );
                            },
                          );
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                        backgroundColor: red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ]),
                    startActionPane: task.isCompleted == 0
                        ? ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDailoges(
                                        onPressyes: () {
                                          Get.back();
                                          _noteController.isCompleted(task.id!);
                                          _noteController.updateNote();
                                        },
                                        onPresscancel: () {
                                          Get.back();
                                        },
                                        title: 'Complete',
                                        note: 'Do you completed the Task');
                                  },
                                );
                              },
                              icon: Icons.check,
                              label: 'Completed',
                              backgroundColor: blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ])
                        : null,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskTile(_noteController.noteList[index])),
                  )),
                ));
          } else {
            return Container();
          }
        },
      );
    }));
  }
}
