import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import './models/image_model.dart';
import './repositories/image_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MyHomePage(
          title: 'Galeria de fotos',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ImageCapture())),
          ),
          SizedBox(
            width: 10,
          )
        ],
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              fit: FlexFit.tight,
              child: Container(
                  child: StreamBuilder(
                stream: Firestore.instance.collection('images').snapshots(),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Sem fotos');
                  } else {
                    var imageRepository = ImageRepository();
                    var listImages = imageRepository
                        .fromSnapshotToModelList(snapshot.data.documents);

                    switch (snapshot.connectionState) {
                      
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return ListView.builder(
                            itemCount: listImages.length,
                            itemBuilder: (_, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(listImages[index].title),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(listImages[index].description),
                                  ),
                                  Container(
                                    color:Colors.grey[400],
                                      height: 250,
                                      child: Image.network(
                                        listImages[index].url,
                                        fit: BoxFit.cover,
                                      ))
                                ],
                              );
                            });
                    }
                  }
                },
              ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ImageCapture())),
        tooltip: 'Adicionar Imagem',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Recorte a imagem');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: Colors.purple,
        child: Row(
          children: <Widget>[
            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(ImageSource.camera)),
            ),
            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(ImageSource.gallery)),
            )
          ],
        ),
      ),
      body: _imageFile == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Nenhuma foto selecionada',
                  textAlign: TextAlign.center,
                )
              ],
            )
          : ListView(
              children: <Widget>[
                Container(
                    height: 370,
                    child: Image.file(
                      _imageFile,
                      fit: BoxFit.cover,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: _cropImage,
                    ),
                    FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                  ],
                ),
                Uploader(file: _imageFile)
              ],
            ),
      appBar: AppBar(
        title: Text('Selecionar foto'),
      ),
    );
  }
}

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
