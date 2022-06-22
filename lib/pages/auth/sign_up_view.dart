import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist/material_util.dart';
import 'package:todolist/pages/auth/sign_in_view.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final data = GetStorage("Account");

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var viewPassword = true.obs;
    var viewConfirmPassword = true.obs;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.pinimg.com/736x/8d/e5/5c/8de55cb61edfb59bc2e3bc7ca7fbeb28.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const Icon(
                        Icons.arrow_back,
                        color: Colors.deepOrangeAccent,
                      size: 40,
                    ),
                  )
              ),
              const Spacer(),
              const Text("Sign Up",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: MaterialUtils.screenHeight()/30),
              TextField(
                controller: email,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "Email"
                ),
              ),
              SizedBox(height: MaterialUtils.screenHeight()/60),
              Obx(() => Stack(
                children: [
                  TextField(
                    obscureText: viewPassword.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: password,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Password"
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 20,
                      child: GestureDetector(
                          onTap: (){
                            viewPassword.value = !viewPassword.value;
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          )
                      )
                  )
                ],
              )),
              SizedBox(height: MaterialUtils.screenHeight()/60),
              Obx(() => Stack(
                children: [
                  TextField(
                    obscureText: viewConfirmPassword.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: confirmPassword,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Confirm password"
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 20,
                      child: GestureDetector(
                          onTap: (){
                            viewConfirmPassword.value = !viewConfirmPassword.value;
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          )
                      )
                  )
                ],
              )),
              SizedBox(height: MaterialUtils.screenHeight()/40),
              GestureDetector(
                onTap: () {
                  if(GetUtils.isEmail(email.text)){
                    if(password.text != "" && password.text == confirmPassword.text){
                      data.write(email.text, password.text);
                      Get.back();
                    }
                    else{
                      showSnackBar("Please enter password and confirm password");
                    }
                  }
                  else
                  {
                    showSnackBar("Email invalidate");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  width: MaterialUtils.screenWidth(),
                  height: MaterialUtils.screenHeight()/15,
                  child: const Center(
                    child: Text("Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
