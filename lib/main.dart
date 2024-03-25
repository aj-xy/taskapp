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
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
              child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
              return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
                itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return GestureDetector(onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return display(user: data);
                 },));
                },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Padding(padding: EdgeInsets.all(20)),
                        Text(data['Title']),
                        Text(data['Task']),
                      ],
                    ),
                  ),
                );
              });
              
              
   } )
   
              ),
    ),
    floatingActionButton: FloatingActionButton(onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) {
         return setapp();
       },));
    },child: Icon(Icons.add),),
    );
  }
}
