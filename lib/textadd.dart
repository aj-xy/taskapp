
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class setapp extends StatefulWidget {
  setapp({super.key});

  @override
  State<setapp> createState() => _setappState();
}

class _setappState extends State<setapp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController TitleController = TextEditingController();

  TextEditingController TaskController = TextEditingController();

  CollectionReference Notes = FirebaseFirestore.instance.collection('Notes');

  Future<void> addUser() {
    return Notes
        .add({
          'Title': TitleController.text,
          'Task': TaskController.text,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SafeArea(
                child: Column(
              children: [
                DecoratedBox(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(200, 198, 215, 1))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Add Tasks",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: TitleController,
                          decoration: InputDecoration(
                              hintText: "Title",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: TaskController,
                          decoration: InputDecoration(
                              hintText: "Task",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Color.fromRGBO(10, 33, 15, 1),
                                backgroundColor: Color.fromRGBO(74, 64, 99, 1)),
                            onPressed:(){ addUser(); Navigator.pop(context);},
                            child: Text("Add")),
                       
                      ],
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
