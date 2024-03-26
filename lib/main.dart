import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskapp/display.dart';
import 'package:taskapp/firebase_options.dart';
import 'package:taskapp/textadd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: notes());
  }
}

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(214, 238, 255, 1),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Notes').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                var size = MediaQuery.of(context).size;
                final double itemHeight =
                    (size.height - kToolbarHeight - 24) / 2;
                final double itemWidth = size.width / 2;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(color: Color.fromRGBO(0, 29, 74, 1) ,
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),SizedBox(height: 20,),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (itemHeight / itemWidth),
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return display(user: data);
                                    },
                                  ));
                                },
                                child: Card(
                                  color: Color.fromRGBO(0, 29, 74, 1),
                                  elevation: 15.0,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          data['Title'],
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                        ),
                                        Text(
                                          data['Task'],
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ]);
              }),
        )),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor:  Color.fromRGBO(0, 29, 74, 1),foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return setapp();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
