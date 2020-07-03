import './base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageItem extends BaseModel {

  String title;
  String description;
  String url;

  ImageItem({this.title,this.description,this.url});

  ImageItem.fromMap(DocumentSnapshot document){
    fromBaseMap(document);
    title = document.data["title"];
    description = document.data["description"];
    url = document.data["url"];
  }
  
  @override
  Map toMap() {
    var map = <String,dynamic> {};
    map.addAll(toBaseMap());
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;

    return map;
  }

}