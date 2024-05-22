import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingRepoImpl repoImpl;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  const tException = CacheException(message: 'Insufficient storage');

  // هاض الاختبار ليس ضروري بس للتأكيد
  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test(
      'should call the [LocalDataSource.cacheFirstTimer] and complete '
      'successfully when the call to the Local source is successful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the local '
      'source is unsuccessful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          tException,
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(
          result,
          equals(
            Left<CacheFailure, dynamic>(
              CacheFailure.fromException(tException),
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should return true when user is first timer',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => true,
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the local '
      'source is unsuccessful',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          tException,
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(
          result,
          equals(
            Left<CacheFailure, dynamic>(
              CacheFailure.fromException(tException),
            ),
          ),
        );
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
