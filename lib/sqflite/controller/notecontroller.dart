import 'package:get/get.dart';
import 'package:revision/sqflite/database/notehelpers.dart';
import 'package:revision/sqflite/model/notemodel.dart';

class NoteController extends GetxController {
  @override
  void onReady() {
    updateNote();
    // TODO: implement onReady
    super.onReady();
  }

  var noteList = [].obs;
  Future<int> addNoteFromUi({Task? notes}) async {
    updateNote();
    return await DBHelper.insert(notes);
  }

  Future updateNote() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    noteList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

  Future<int> deleteNote(Task task) {
    updateNote();
    return DBHelper.delete(task);
  }

  Future isCompleted(int id) async {
    updateNote();
    await DBHelper.isCompleted(id);
  }
}
