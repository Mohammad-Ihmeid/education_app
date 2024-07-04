import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/usecases/add_course.dart';
import 'package:education_app/src/course/domain/usecases/get_courses.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCourse extends Mock implements AddCourse {}

class MockGetCourses extends Mock implements GetCourses {}

void main() {
  late AddCourse addCourse;
  late GetCourses getCourses;
  late CourseCubit cubit;

  final tCourse = CourseModel.empty();
  const tServerException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  setUp(() {
    addCourse = MockAddCourse();
    getCourses = MockGetCourses();
    cubit = CourseCubit(addCourse: addCourse, getCourses: getCourses);
    registerFallbackValue(tCourse);
  });

  tearDown(() => cubit.close());

  test('initial state should be [CubitInitial]', () async {
    expect(cubit.state, const CourseInitial());
  });

  group('addCourse', () {
    blocTest<CourseCubit, CourseState>(
      'emits [AddingCourse, CourseAdded] when addCourse is called',
      build: () {
        when(() => addCourse(any())).thenAnswer((_) async => const Right(null));

        return cubit;
      },
      act: (cubit) => cubit.addCourse(tCourse),
      expect: () => <CourseState>[
        const AddingCourse(),
        const CourseAdded(),
      ],
      verify: (_) {
        verify(() => addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(addCourse);
      },
    );

    blocTest<CourseCubit, CourseState>(
      'emits [AddingCourse, CourseError] when addCourse is called',
      build: () {
        when(() => addCourse(any())).thenAnswer(
          (_) async => Left(ServerFailure.fromException(tServerException)),
        );

        return cubit;
      },
      act: (cubit) => cubit.addCourse(tCourse),
      expect: () => const [
        AddingCourse(),
        CourseError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(addCourse);
      },
    );
  });

  group('getCourses', () {
    blocTest<CourseCubit, CourseState>(
      'emits [LoadingCourses, CoursesLoaded] when getCourses is called',
      build: () {
        when(() => getCourses()).thenAnswer((_) async => Right([tCourse]));

        return cubit;
      },
      act: (cubit) => cubit.getCourses(),
      expect: () => <CourseState>[
        const LoadingCourses(),
        CoursesLoaded([tCourse]),
      ],
      verify: (_) {
        verify(() => getCourses()).called(1);
        verifyNoMoreInteractions(getCourses);
      },
    );

    blocTest<CourseCubit, CourseState>(
      'emits [LoadingCourses, CourseError] when getCourses is called',
      build: () {
        when(() => getCourses()).thenAnswer(
          (_) async => Left(ServerFailure.fromException(tServerException)),
        );

        return cubit;
      },
      act: (cubit) => cubit.getCourses(),
      expect: () => const [
        LoadingCourses(),
        CourseError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => getCourses()).called(1);
        verifyNoMoreInteractions(getCourses);
      },
    );
  });
}
