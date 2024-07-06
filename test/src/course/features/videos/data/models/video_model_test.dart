import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixtures_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date = DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!)
      .add(Duration(microseconds: timestampData['_nanoseconds']!));

  final timestamp = Timestamp.fromDate(date);

  final tModel = VideoModel.empty();

  test(
    'should be a subclass of [Video] entity',
    () {
      expect(tModel, isA<Video>());
    },
  );

  final tJson = fixture('video.json');
  final tMap = jsonDecode(tJson) as DataMap;
  tMap['uploadDate'] = timestamp;

  group('fromMap', () {
    test(
      'should return a valid [VideoModel] from the Map',
      () {
        final result = VideoModel.fromMap(tMap);

        expect(result, isA<VideoModel>());
        expect(result, equals(tModel));
      },
    );
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () async {
      final result = tModel.toMap()..remove('uploadDate');

      final map = DataMap.from(tMap)..remove('uploadDate');
      expect(result, equals(map));
    });
  });

  group('copyWith', () {
    test('should return a valid [LocalUserModel] with updated values', () {
      final result = tModel.copyWith(tutor: 'New Tutor');
      expect(result.tutor, 'New Tutor');
    });
  });
}
