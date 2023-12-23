// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  final dialogUserNameController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  // CollectionReference users =  FirebaseFirestore.instance.collection('COLLECTION NAME');
  CollectionReference users = FirebaseFirestore.instance.collection('usersss');
  myDialog( Map data,dynamic myKey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: dialogUserNameController,
                    maxLength: 20,
                    decoration: InputDecoration(hintText:" ${data[myKey]}")),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          // addnewtask();
                          setState(() {
                            users.doc(credential!.uid).update(
                                {myKey: dialogUserNameController.text});
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 22),
                        )),
                    TextButton(
                        onPressed: () {
                          // addnewtask();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 22),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userr =
        FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: userr.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: ${data['username']}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                        IconButton(
                        onPressed: () {
                          setState(() {
                            users.doc(credential!.uid).update({'username': FieldValue.delete()});
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          myDialog(data,'username');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email: ${data['email']}",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            users.doc(credential!.uid).update({'email': FieldValue.delete()});
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                           myDialog(data,'email');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password: ${data['Password']}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            users.doc(credential!.uid).update({'Password': FieldValue.delete()});
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                           myDialog(data,'Password');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age: ${data['age']} years old",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            users.doc(credential!.uid).update({'age': FieldValue.delete()});
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                           myDialog(data,'age');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title: ${data['title']} ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            users.doc(credential!.uid).update({'title': FieldValue.delete()});
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                           myDialog(data,'title');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                   setState(() {
                      users.doc(credential!.uid).delete();
                   });
                  },
                   child: Text("Delete Data",style: TextStyle(fontSize: 18),),
                  ),
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
