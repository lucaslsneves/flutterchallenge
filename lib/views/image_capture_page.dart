import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import './uploader.dart';

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