// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(SignUpParams params) {
    return _authRepo.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullName,
    required this.password,
  });

  final String email;
  final String fullName;
  final String password;

  const SignUpParams.empty() : this(email: '', fullName: '', password: '');

  @override
  List<Object> get props => [email, fullName, password];
}
