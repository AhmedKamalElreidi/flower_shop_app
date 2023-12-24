// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unused_local_variable, avoid_print, depend_on_referenced_packages
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/pages/home.dart';
import 'package:e_commerce_app/pages/login.dart';
import 'package:e_commerce_app/shared_widget/colors.dart';
import 'package:e_commerce_app/shared_widget/constant.dart';
import 'package:e_commerce_app/shared_widget/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isobscureText = true;
  File? imgPath;
  String? imgName;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();

  bool isPassword8Char = false;
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  onPasswordChanged(String password) {
    isPassword8Char = false;
    hasUppercase = false;
    hasDigits = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      } else {}
    });
  }

  uploadImage2screen(ImageSource type) async {
    final pickedImg = await ImagePicker().pickImage(source: type);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
    Navigator.pop(context);
  }

  showModel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  uploadImage2screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "from camera",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);

      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');

      users
          .doc(credential.user!.uid)
          .set({
            'username': usernameController.text,
            'age': ageController.text,
            'title': titleController.text,
            'email': emailController.text,
            'Password': passwordController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showSnackBar(context, "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text("Register "),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(128, 78, 91, 110)),
                      child: Stack(children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                radius: 64,
                                backgroundImage:
                                    AssetImage("assets/img/avatar.png"),
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          left: 95,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              showModel();
                            },
                            icon: Icon(Icons.add_a_photo),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your UserName : ",
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your age : ",
                            suffixIcon: Icon(Icons.pest_control_rodent))),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your title : ",
                            suffixIcon: Icon(Icons.person_outline))),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        onPasswordChanged(value);
                      },
                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at Least 8 character"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isobscureText ? true : false,
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Password : ",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Icon(Icons.visibility_off);
                              isobscureText = !isobscureText;
                            });
                          },
                          icon: isobscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isPassword8Char ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child:
                              Icon(Icons.check, size: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At Least 8 Character "),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasDigits ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child:
                              Icon(Icons.check, size: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At Least 1 Number "),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasUppercase ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child:
                              Icon(Icons.check, size: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has UpperCase "),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasLowercase ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child:
                              Icon(Icons.check, size: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has LowerCase "),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasSpecialCharacters
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child:
                              Icon(Icons.check, size: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has Special Character "),
                      ],
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
                          showSnackBar(context, "Done");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } else {
                          showSnackBar(context, "error");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(bTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Register", style: TextStyle(fontSize: 19)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have an account ?",
                            style: TextStyle(fontSize: 15)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('Sign In',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
