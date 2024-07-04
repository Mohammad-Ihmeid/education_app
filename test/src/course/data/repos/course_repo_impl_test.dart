import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/data/repos/course_repo_impl.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSrc extends Mock implements CourseRemoteDataSrc {}

void main() {
  late CourseRepoImp repoImp;
  late CourseRemoteDataSrc remoteDataSrc;

  final tCourse = CourseModel.empty();

  setUp(() {
    remoteDataSrc = MockCourseRemoteDataSrc();
    repoImp = CourseRepoImp(remoteDataSrc);
    registerFallbackValue(tCourse);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('addCourse', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.addCourse(any()))
            .thenAnswer((_) async => Future.value());

        final result = await repoImp.addCourse(tCourse);

        expect(result, const Right<dynamic, void>(null));
        verify(() => remoteDataSrc.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.addCourse(any())).thenThrow(tException);

        final result = await repoImp.addCourse(tCourse);

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tException),
          ),
        );
        verify(() => remoteDataSrc.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('getCourse', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.getCourse())
            .thenAnswer((_) async => [tCourse]);

        final result = await repoImp.getCourse();

        expect(result, isA<Right<dynamic, List<Course>>>());
        verify(() => remoteDataSrc.getCourse()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getCourse()).thenThrow(tException);

        final result = await repoImp.getCourse();

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tException),
          ),
        );
        verify(() => remoteDataSrc.getCourse()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
