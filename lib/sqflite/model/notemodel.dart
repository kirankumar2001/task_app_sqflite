// import 'dart:convert';

// class Note {
//   int? id;
//   String? title;
//   String? note;
//   int? isCompleted;
//   String? date;
//   String? startTime;
//   String? endTime;
//   String? reminder;
//   String? repeate;
//   Note({
//     this.id,
//     this.title,
//     this.note,
//     this.isCompleted,
//     this.date,
//     this.startTime,
//     this.endTime,
//     this.reminder,
//     this.repeate,
//   });
//   Note.fromJson(Map<String, dynamic> json) {
//     id = json['id']?.toInt();
//     title = json['title'];
//     note = json['note'];
//     isCompleted = json['isCompleted'];
//     date = json['date'];
//     startTime = json['startTime'];
//     endTime = json['endTime'];
//     reminder = json['reminder'];
//     repeate = json['repeate'];
//   }
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['note'] = this.note;
//     data['isCompleted'] = this.isCompleted;
//     data['date'] = this.date;
//     data['startTime'] = this.startTime;
//     data['endTime'] = this.endTime;
//     data['reminder'] = this.reminder;
//     data['repeate'] = this.repeate;
//     return data;
//   }
// }

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  dynamic endTime;
  int? color;
  dynamic remind;
  String? repeat;
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }
}
