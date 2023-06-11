import 'package:chat_flutter/chat-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  runApp(MyApp());
  // Create the initilization Future outside of `build`:
  FirebaseApp defaultApp = await Firebase.initializeApp();
  //Writing data
  // FirebaseFirestore.instance.collection('mensagens').doc().set({
  //   'texto' : 'ai pai para',
  //   'from' : 'Braio',
  //   'read' : 'false'
  // });

  //Reading data (all documents)
  // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('mensagens').get();
  // snapshot.docs.forEach((element) {
  //   print(element.data());
  // });

  //Reading one document by Id
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('mensagens').doc('5Fy42Wa53XY1ynwwjMoD').get();
  // print(snapshot.data());
  // snapshot.reference.update({'read': false});
  // print(snapshot.data());

  //getting att notification
  // FirebaseFirestore.instance.collection('mensagens').snapshots().listen((event) {
  //   event.docs.forEach((element) {
  //     print(element.data());
  //   });
  // });

}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.blue,
        ),
      ),
      home: ChatScreen(),
    );
  }
}