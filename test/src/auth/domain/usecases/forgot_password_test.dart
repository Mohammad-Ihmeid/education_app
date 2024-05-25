import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late ForgotPassword usecase;
  late AuthRepo repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = ForgotPassword(repository);
  });

  test(
    'should call the [AuthRepo.forgotPassword] '
    'and return the right data',
    () async {
      when(() => repository.forgotPassword(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase('email');

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.forgotPassword('email')).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
