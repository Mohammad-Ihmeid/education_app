import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late SignIn usecase;
  late AuthRepo repository;

  const tEmail = 'Test email';
  const tPassword = 'Test Password';

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignIn(repository);
  });

  const tUser = LocalUser.empty();

  test(
    'should return [LocalUser] from the [AuthRepo]',
    () async {
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      final result =
          await usecase(const SignInParams(email: tEmail, password: tPassword));

      expect(
        result,
        equals(const Right<dynamic, LocalUser>(tUser)),
      );
      verify(() => repository.signIn(email: tEmail, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
