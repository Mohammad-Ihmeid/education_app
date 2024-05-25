import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late UpdateUser usecase;
  late AuthRepo repository;

  const tAction = UpdateUserAction.displayName;
  const tUserData = 'Test UserData';

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.displayName);
  });

  test(
    'should call the [AuthRepo.updateUser] '
    'and return the right data',
    () async {
      when(
        () => repository.updateUser(
          action: any(named: 'action'),
          userData: any<String>(named: 'userData'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const UpdateUserParams(action: tAction, userData: tUserData),
      );

      expect(
        result,
        equals(const Right<dynamic, void>(null)),
      );
      verify(
        () => repository.updateUser(action: tAction, userData: tUserData),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
