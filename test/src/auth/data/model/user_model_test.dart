import 'dart:convert';

import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/data/model/user_model.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tModel = LocalUserModel.empty();

  test(
    'should be a subclass of [LocalUser] entity',
    () {
      expect(tModel, isA<LocalUser>());
    },
  );

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test(
      'should return a valid [LocalUserModel] from the Map',
      () {
        final result = LocalUserModel.fromMap(tMap);

        expect(result, isA<LocalUserModel>());
        expect(result, equals(tModel));
      },
    );

    test(
      'should throw an [Error] when the map is invalid',
      () {
        final map = DataMap.from(tMap)..remove('uid');

        const call = LocalUserModel.fromMap;

        expect(() => call(map), throwsA(isA<Error>()));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a valid [DataMap] from the model',
      () {
        final result = tModel.toMap();
        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test('should return a valid [LocalUserModel] with updated values', () {
      final result = tModel.copyWith(fullName: 'Mohammad');
      expect(result.fullName, equals('Mohammad'));
    });
  });
}
