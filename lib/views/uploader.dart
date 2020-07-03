import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/image_model.dart';
import '../repositories/image_repository.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://flutterchalenge.appspot.com');

  StorageUploadTask _uploadTask;
  final filePath = 'images/${DateTime.now()}.png';
  void _startUpload() async {
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });  

    var url = await (await _uploadTask.onComplete).ref.getDownloadURL();


    var img = ImageItem(title:'Título', description: 'Lorem Ipsum Descrição',url: url);

    var id = ImageRepository().add(img);

    Navigator.of(context).pop();
  }


  


  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
        
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text('Enviado'),
              LinearProgressIndicator(value: progressPercent),
              Text('${(progressPercent * 100).toStringAsFixed(2)}%')
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
          label: Text('Upload to firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload);
    }
  }
}
