import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  ForgotPassword(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(String params) => _authRepo.forgotPassword(params);
}
