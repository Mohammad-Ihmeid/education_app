// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) async {
    return _authRepo.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  const SignInParams.empty() : this(email: '', password: '');

  @override
  List<Object> get props => [email, password];
}
