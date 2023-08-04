import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:revision/sqflite/controller/notecontroller.dart';
import 'package:revision/sqflite/model/notemodel.dart';
import 'package:revision/sqflite/utils/themes.dart';
import 'package:revision/sqflite/utils/widgets/elevated.dart';
import 'package:revision/sqflite/utils/widgets/input_textfield.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final NoteController _noteController = Get.put(NoteController());
  final TextEditingController title = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController datec = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();
  final TextEditingController reminder = TextEditingController();
  final TextEditingController repeated = TextEditingController();

  List<int> remindList = [5, 10, 15, 20];
  int _reminder = 5;
  List<String> repeatlist = ["None", "Daily", "Weekly", "Monthly", "Yearly"];
  var selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  "Add Task",
                  style: headingStyle2,
                ),
              ),
              InputText(
                  readOnly: false,
                  title: 'Title',
                  hint: 'Enter title here',
                  textcontroller: title),
              InputText(
                readOnly: false,
                title: 'Note',
                hint: 'Enter note here',
                textcontroller: note,
              ),
              InputText(
                readOnly: false,
                textcontroller: datec,
                title: 'Date',
                hint: 'Select Date',
                widget: IconButton(
                    onPressed: () {
                      _calender(context);
                    },
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      size: 25,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputText(
                    readOnly: false,
                    textcontroller: start,
                    title: 'Start Time',
                    hint: 'Select Time',
                    widget: IconButton(
                        onPressed: () {
                          _startTime(context);
                        },
                        icon: Icon(Icons.access_time_rounded)),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InputText(
                    readOnly: false,
                    textcontroller: end,
                    title: 'End Time',
                    hint: 'Select Time',
                    widget: IconButton(
                        onPressed: () {
                          _endtTime(context);
                        },
                        icon: Icon(Icons.access_time_rounded)),
                  ))
                ],
              ),
              InputText(
                readOnly: true,
                textcontroller: reminder,
                title: 'Reminder',
                hint: '$_reminder',
                widget: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 34,
                    ),
                  ),
                  items: remindList
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem(
                          value: value.toString(),
                          child: Text('$value'),
                        ),
                      )
                      .toList(),
                  style: subHeadingStyle,
                  onChanged: (String? value) {
                    setState(() {
                      _reminder = int.parse(value!);
                    });
                  },
                ),
              ),
              InputText(
                readOnly: true,
                textcontroller: repeated,
                title: 'Repeat',
                hint: 'None',
                widget: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:
                      repeatlist.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      child: Text(value.toString()),
                      value: value.toString(),
                    );
                  }).toList(),
                  onChanged: (value) {
                    repeated.text = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPalet(),
                    Elevated(
                      label: "Create Task",
                      onTap: () {
                        _validator(context);
                        print(_noteController.noteList.length);
                        _noteController.updateNote();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addNoteDb() async {
    var value = await _noteController.addNoteFromUi(
        notes: Task(
            title: title.text,
            note: note.text,
            date: datec.text,
            startTime: start.text,
            endTime: end.text,
            color: selectedColor,
            remind: _reminder,
            repeat: repeated.text,
            isCompleted: 0));
    print(value);
  }

  _validator(BuildContext context) async {
    if (title.text.isNotEmpty && note.text.isNotEmpty) {
      await _addNoteDb();
      // _addNoteDb();
      Get.back();
      context.showSuccessBar(
          position: FlashPosition.top,
          content: Text("Task Added Successfully"),
          icon: Icon(
            Icons.check_circle_outline_outlined,
            color: grrenclr,
          ));
      // MotionToast.success(
      //         position: MotionToastPosition.top,
      //         animationType: AnimationType.fromLeft,
      //         title: Text("Success"),
      //         description: Text("Task Added Successfully"))
      //     .show(context);
    } else if (title.text.isEmpty || note.text.isEmpty) {
      context.showErrorBar(
          position: FlashPosition.top,
          content: Text("Something is missing"),
          icon: Icon(
            Icons.error_outline,
            color: red,
          ));
      // MotionToast.error(
      //         position: MotionToastPosition.top,
      //         animationType: AnimationType.fromLeft,
      //         title: Text("Error"),
      //         description: Text("Something is missing"))
      //     .show(context);
    }
  }

  _colorPalet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? primary
                      : index == 1
                          ? pinkclr
                          : index == 2
                              ? yellowclr
                              : index == 3
                                  ? grrenclr
                                  : red,
                  radius: 14,
                  child: selectedColor == index
                      ? Icon(
                          Icons.done,
                          size: 16,
                          color: primarybg,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: Get.isDarkMode ? primarybg : darkbg,
          )),
    );
  }

  void _calender(BuildContext context) async {
    DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (_dateTime != null) {
      setState(() {
        datec.text = DateFormat.yMd().format(_dateTime);
      });
    } else {
      print("Date not selected");
    }
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   var selectedTime = TimeOfDay.now();
  //   final TimeOfDay? picked_s = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );

  //   if (picked_s != null && picked_s != selectedTime)
  //     setState(() {
  //       selectedTime = picked_s;
  //     });
  // }

  void _startTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        start.text = time.format(context);
      });
    } else {
      print("Time not selected");
    }
  }

  void _endtTime(BuildContext context) async {
    TimeOfDay? time2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      if (time2 != null) {
        end.text = time2.format(context);
      }
    });
  }
}
