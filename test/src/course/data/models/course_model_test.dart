import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date = DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!)
      .add(Duration(microseconds: timestampData['_nanoseconds']!));

  final timestamp = Timestamp.fromDate(date);
  final tCourseModel = CourseModel.empty();

  test(
    'should be a subclass of [Course] entity',
    () {
      expect(tCourseModel, isA<Course>());
    },
  );

  final tJson = fixture('course.json');
  final tMap = jsonDecode(tJson) as DataMap;
  tMap['createdAt'] = timestamp;
  tMap['updatedAt'] = timestamp;

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [CourseModel] with the correct data', () {
      final result = CourseModel.fromMap(tMap);

      //expect(result, isA<CourseModel>());
      expect(result, equals(tCourseModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');

      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');
      expect(result, equals(map));
    });
  });

  group('copyWith', () {
    test('should return a [CourseModel] with the new data', () {
      final result = tCourseModel.copyWith(
        title: 'New Data',
      );
      expect(result.title, 'New Data');
    });
  });
}
