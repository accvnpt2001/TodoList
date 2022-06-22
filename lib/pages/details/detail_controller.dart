import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todolist/database/db_helper.dart';
import 'package:todolist/pages/home/todo_model.dart';

class DetailController extends GetxController{
  // 0: Add, 1: Update
  int service = 0;
  int? selectedId;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController desTextController = TextEditingController();
  TextEditingController dueTextController = TextEditingController();

  void add() async {
      DBHelper.instance.insert(
          TodoModel(
              title: titleTextController.text,
              description: desTextController.text,
              due: dueTextController.text ,
              level: 3
          )
      );
  }

  void updateTodo() async {
      DBHelper.instance.update(
          TodoModel(
              id: selectedId,
              title: titleTextController.text,
              description: desTextController.text,
              due: dueTextController.text ,
              level: 3
          )
      );
  }
}