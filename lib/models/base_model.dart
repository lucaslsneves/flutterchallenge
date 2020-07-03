import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/base_model_interface.dart';

// Todos os models da aplicação irão extender este

class BaseModel implements IBaseModelInterface {
  BaseModel();
  // Cria uma instancia a partir de um map
  BaseModel.fromMap(DocumentSnapshot document);

  String id;
  bool isActive = true;
  Timestamp createdAt;
  Timestamp updatedAt;
  
  // Transforma uma instancia em map 
  @override
  Map toBaseMap() {
    var map = <String, dynamic>{};

    map['isActive'] = isActive;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;

    return map;
  }
  // Cria uma instancia a partir de um map
  @override
  void fromBaseMap(DocumentSnapshot document){
    id = document.documentID;
    isActive = document.data["isActive"];
    createdAt = document.data["createdAt"];
    updatedAt = document.data["updatedAt"];
  }

   @override
  void disableDocument () => isActive = false;

  @override
  void enableDocument () => isActive = true;

  @override
  void setCreateTime () => createdAt = Timestamp.now();

  @override
  void setUpdateTime () => updatedAt = Timestamp.now();

  @override
  String documentId () => id;

  @override
  Map toMap () => null;
}
