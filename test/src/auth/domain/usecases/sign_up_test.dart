import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late SignUp usecase;
  late AuthRepo repository;

  const tEmail = 'Test email';
  const tFullName = 'Test fullName';
  const tPassword = 'Test Password';

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignUp(repository);
  });

  test(
    'should call the [AuthRepo.signUp] '
    'and return the right data',
    () async {
      when(
        () => repository.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const SignUpParams(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        ),
      );

      expect(
        result,
        equals(const Right<dynamic, void>(null)),
      );
      verify(
        () => repository.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
