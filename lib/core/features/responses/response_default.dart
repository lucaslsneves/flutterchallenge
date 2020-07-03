import '../../enums/app_enums.dart';

// Tipando as respostas das requisições
class DefaultResponse<T> {
  final T object;
  final String message;
  final ResponseStatus status;

  DefaultResponse({this.object,this.message,this.status});

}