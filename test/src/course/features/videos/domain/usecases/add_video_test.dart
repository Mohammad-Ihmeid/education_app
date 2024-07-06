import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video_repo.mock.dart';

void main() {
  late AddVideo usecase;
  late VideoRepo repository;

  final tVideo = Video.empty();

  setUp(() {
    repository = MockVideoRepo();
    usecase = AddVideo(repository);
    registerFallbackValue(tVideo);
  });

  test('should call [VideoRepo.addVideo]', () async {
    when(() => repository.addVideo(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(tVideo);

    expect(
      result,
      equals(const Right<dynamic, void>(null)),
    );
    verify(() => repository.addVideo(tVideo)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
