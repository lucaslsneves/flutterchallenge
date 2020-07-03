import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../repositories/image_repository.dart';
import 'image_capture_page.dart';

class MyHomePage extends StatefulWidget {
  
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
        title: Text('Galeria de fotos'),
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
                    listImages.sort((a,b) {
                     return b.createdAt.toString().compareTo(a.createdAt.toString());
                    });
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