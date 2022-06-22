import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist/material_util.dart';
import 'package:todolist/pages/auth/sign_up_view.dart';
import 'package:todolist/pages/home/home_view.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final data = GetStorage("Account");

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RxBool viewPassword = true.obs;

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
              const Spacer(),
              const Text("Sign In",
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
              SizedBox(height: MaterialUtils.screenHeight()/40),
              GestureDetector(
                onTap: (){
                  if(GetUtils.isEmail(email.text)){
                    if(data.read(email.text) == null ){
                      showSnackBar("This account isn't exits");
                    }
                    else if(password.text == data.read(email.text)){
                      Get.to(HomePage());
                    }
                    else{
                      showSnackBar("Wrong password");
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
                    child: Text("Sign In",
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("You don't have account",
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic)
                    ),
                    GestureDetector(
                      onTap: () => Get.to(SignUp()),
                      child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange[200],
                        ),
                      ),
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
}

void showSnackBar(String message){
  Get.snackbar(
    message,
    "",
    colorText: Colors.white,
    animationDuration:const Duration(seconds: 1),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: Colors.red,
  );
}
