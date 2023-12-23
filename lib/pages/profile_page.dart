// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_print

import 'dart:io';

import 'package:e_commerce_app/shared_widget/colors.dart';
import 'package:e_commerce_app/shared_widget/getdata_from_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
   uploadImage2screen() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
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
                                setState(() {
                                  uploadImage2screen();
                                });
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          ),
                        ]),
                      ),
              ),
              SizedBox(height: 15,),
              Center(
                  child: Container(
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email: ${credential!.email}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Created date:  ${DateFormat("MMM d,y").format(credential!.metadata.creationTime!)} ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Last Signed In:  ${DateFormat("MMM d,y").format(credential!.metadata.lastSignInTime!)} ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                   setState(() {
                    CollectionReference users =  FirebaseFirestore.instance.collection('usersss');
                    credential!.delete();
                    users.doc(credential!.uid).delete();
                    Navigator.pop(context);
                   });
                  },
                   child: Text("Delete User",style: TextStyle(fontSize: 18),),
                  ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              GetDataFromFirestore(documentId:credential!.uid),
            ],
          ),
        ),
      ),
    );
  }
}
