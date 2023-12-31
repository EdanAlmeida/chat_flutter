import 'dart:io';

import 'package:chat_flutter/text-composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _sendMessage({String? text, XFile? imgFile}) async {
    if(imgFile != null) {
      UploadTask task = FirebaseStorage.instance.ref().child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile as File);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
    }

    FirebaseFirestore.instance.collection('messages').doc().set(
      {'texto': text
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot?>(
              stream: FirebaseFirestore.instance.collection('messages').snapshots()),
              builder: (context, snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                       List<DocumentSnapshot> documents = snapshot.data.documents;

                       return ListView.builder(
                           itemCount: documents.length,
                           reverse: true,
                           itemBuilder: (context, index) {
                             ListTile(
                               title: Text(documents[index].data['texto']),
                             );
                           }
                       );
                  }
                },
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
