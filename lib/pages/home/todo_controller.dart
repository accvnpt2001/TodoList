
import 'package:get/get.dart';
import 'package:todolist/database/db_helper.dart';
import 'package:todolist/pages/home/todo_model.dart';

class TodoController extends GetxController{
  var isLoading = true.obs;
  RxList<TodoModel> todoList = <TodoModel>[].obs;

  @override
  void onInit(){
    getTodoList();
    super.onInit();
  }

  void getTodoList() async {
    try{
      isLoading(true);
      var list = await DBHelper.instance.read();
      todoList.assignAll(list);
    }
    finally {
      isLoading(false);
    }
  }

  void delete(TodoModel todo) async{
    await DBHelper.instance.delete(todo.id);
    getTodoList();
  }

}