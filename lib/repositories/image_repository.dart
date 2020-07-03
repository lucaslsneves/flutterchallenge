
import 'package:cloud_firestore/cloud_firestore.dart';
import './base_firebase_repository.dart';
import '../models/image_model.dart';


class ImageRepository extends BaseFirebaseRepository<ImageItem> {
  @override
  String get collection => 'images';

  @override
  ImageItem Function(DocumentSnapshot document) get fromMap => 
      (document) => ImageItem.fromMap(document);
}