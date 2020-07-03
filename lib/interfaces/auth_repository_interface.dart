import '../core/features/responses/response_default.dart';

abstract class IAuthRepository {
  Future<DefaultResponse> doLoginGoogle();
}