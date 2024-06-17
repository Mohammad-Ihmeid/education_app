import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/data/model/user_model.dart';
import 'package:education_app/src/auth/data/repos/auth_repo_impl.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepoImpl repoImpl;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthRepoImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.displayName);
  });

  const tException = ServerException(message: 'message', statusCode: '404');
  const tLocalUserModel = LocalUserModel.empty();

  test('should be a subclass of [AuthRepo]', () {
    expect(repoImpl, isA<AuthRepo>());
  });

  group('forgotPassword', () {
    test(
      'should call the [RemoteDataSource.forgotPassword] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(() => remoteDataSource.forgotPassword(any()))
            .thenAnswer((_) async => Future.value());

        final result = await repoImpl.forgotPassword('email');

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSource.forgotPassword('email')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(() => remoteDataSource.forgotPassword(any()))
            .thenThrow(tException);

        final result = await repoImpl.forgotPassword('email');

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(() => remoteDataSource.forgotPassword('email')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signIn', () {
    test(
      'should call the [RemoteDataSource.signIn] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tLocalUserModel);

        final result =
            await repoImpl.signIn(email: 'email', password: 'password');

        expect(
          result,
          equals(const Right<dynamic, LocalUserModel>(tLocalUserModel)),
        );
        verify(
          () => remoteDataSource.signIn(email: 'email', password: 'password'),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tException);

        final result =
            await repoImpl.signIn(email: 'email', password: 'password');

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.signIn(email: 'email', password: 'password'),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signUp', () {
    test(
      'should call the [RemoteDataSource.signUp] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repoImpl.signUp(
          email: 'email',
          fullName: 'fullName',
          password: 'password',
        );

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.signUp(
            email: 'email',
            fullName: 'fullName',
            password: 'password',
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tException);

        final result = await repoImpl.signUp(
          email: 'email',
          fullName: 'fullName',
          password: 'password',
        );

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.signUp(
            email: 'email',
            fullName: 'fullName',
            password: 'password',
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('updateUser', () {
    test(
      'should call the [RemoteDataSource.updateUser] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<String>(named: 'userData'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repoImpl.updateUser(
          action: UpdateUserAction.displayName,
          userData: 'mohammad',
        );

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.updateUser(
            action: UpdateUserAction.displayName,
            userData: 'mohammad',
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<String>(named: 'userData'),
          ),
        ).thenThrow(tException);

        final result = await repoImpl.updateUser(
          action: UpdateUserAction.displayName,
          userData: 'mohammad',
        );

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.updateUser(
            action: UpdateUserAction.displayName,
            userData: 'mohammad',
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
