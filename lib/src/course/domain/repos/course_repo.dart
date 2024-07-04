import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';

abstract class CourseRepo {
  CourseRepo();

  ResultFuture<List<Course>> getCourse();

  ResultFuture<void> addCourse(Course course);
}
