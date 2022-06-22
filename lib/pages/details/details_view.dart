import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/material_util.dart';
import 'package:todolist/pages/details/detail_controller.dart';
import 'package:todolist/pages/home/todo_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DetailController detailController = Get.put(DetailController());

  @override
  void initState(){
    super.initState();
    if(detailController.service == 0) {
      detailController.titleTextController.clear();
      detailController.desTextController.clear();
      detailController.dueTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text("Details"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.network(
                        "https://jobsgo.vn/blog/wp-content/uploads/2021/07/loi-ich-khi-lam-viec-work-from-home-mua-dich-1.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextField(
                    controller: detailController.titleTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Title"
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextField(
                    controller: detailController.dueTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "Due",
                    ),
                    onTap: (){
                      DateTime now = DateTime.now();

                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: now,
                          maxTime: DateTime(now.year + 1),
                          onConfirm: (date) {
                            detailController.dueTextController.text =
                                DateFormat('KK:mm dd/MM/yyyy').format(date);
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.vi);
                    },
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextField(
                    controller: detailController.desTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Description",
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        onPressed:(){
                          if(detailController.titleTextController.text == "" ){
                            Get.snackbar(
                                "Please enter title",
                                "",
                              animationDuration:const Duration(seconds: 1),
                              duration: const Duration(milliseconds: 1500),
                              backgroundColor: Colors.white,
                              boxShadows: [
                                const BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 3),
                                  spreadRadius: 5,
                                  blurRadius: 5
                                )
                              ],
                            );
                          }
                          else {
                            if(detailController.service == 0) {
                              detailController.add();
                            } else {
                              detailController.updateTodo();
                            }
                            Get.find<TodoController>().getTodoList();
                            Get.back();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.deepOrangeAccent)
                                )
                            )
                        ),
                        child: SizedBox(
                          width: MaterialUtils.screenWidth()/3,
                          height: MaterialUtils.screenHeight() / 15,
                          child: Center(
                              child: Text(detailController.service == 0 ? "Add to list" : "Update")
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
