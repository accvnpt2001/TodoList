import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/material_util.dart';
import 'package:todolist/pages/details/detail_controller.dart';
import 'package:todolist/pages/details/details_view.dart';
import 'package:todolist/pages/home/todo_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  DetailController detailController = Get.put(DetailController());
  TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TodoList"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(() =>
              controller.isLoading.value ?
              const Center(child: CircularProgressIndicator(color: Colors.deepOrange,))
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.todoList.length,
                itemBuilder: (context, index){
                  return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(6),
                      height: MaterialUtils.screenHeight()/6,
                      width: MaterialUtils.screenWidth() * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MaterialUtils.screenWidth()*0.65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.todoList[index].title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Due: ${controller.todoList[index].due.toString()}",
                                    style: const TextStyle(color: Colors.cyan, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "Description: ${controller.todoList[index].description.toString()}",
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Get.find<DetailController>().service  = 1;
                                    detailController.selectedId =
                                        controller.todoList[index].id;
                                    detailController.titleTextController.text =
                                        controller.todoList[index].title.toString();
                                    detailController.desTextController.text =
                                        controller.todoList[index].description.toString();
                                    detailController.dueTextController.text =
                                        controller.todoList[index].due.toString();
                                    Get.to(const Details());
                                  },
                                  child: const Icon(
                                    Icons.edit_note_outlined,
                                    color: Colors.black54,
                                    size: 35,
                                  )
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text('Do you want to delete this item?'),
                                        actions: [
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: (){
                                              controller.delete(controller.todoList[index]);
                                              Get.back();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Close"),
                                            onPressed: () => Get.back(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding:  EdgeInsets.only(left: 5),
                                    child: Icon(Icons.delete, color: Colors.red, size: 30),
                                  )
                              ),
                            ],
                          )
                        ],
                      )
                  );
                },
              ))
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            detailController.service = 0;
            Get.to(() => const Details());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}
