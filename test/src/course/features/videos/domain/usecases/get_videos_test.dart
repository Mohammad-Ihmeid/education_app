import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get_videos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video_repo.mock.dart';

void main() {
  late GetVideos usecase;
  late VideoRepo repository;

  final tVideo = Video.empty();

  setUp(() {
    repository = MockVideoRepo();
    usecase = GetVideos(repository);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      when(() => repository.getVideos(any()))
          .thenAnswer((_) async => Right([tVideo]));

      final result = await usecase('testId');

      expect(
        result,
        isA<Right<dynamic, List<Video>>>(),
      );
      verify(() => repository.getVideos('testId')).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
