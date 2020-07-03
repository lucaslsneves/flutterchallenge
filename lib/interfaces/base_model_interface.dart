import 'package:cloud_firestore/cloud_firestore.dart';

// Interface de um Model
abstract class IBaseModelInterface {
  String documentId();

  Map toMap();

  Map toBaseMap();

  void fromBaseMap(DocumentSnapshot document);

  void enableDocument();

  void disableDocument();

  void setCreateTime();

  void setUpdateTime();
}