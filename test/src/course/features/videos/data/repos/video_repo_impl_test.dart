import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/data/repos/video_repo_impl.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVideoRemoteDataSrc extends Mock implements VideoRemoteDataSrc {}

void main() {
  late VideoRepoImpl repoImpl;
  late VideoRemoteDataSrc remoteDataSource;

  final tVideo = VideoModel.empty();
  const tException = ServerException(
    message: 'message',
    statusCode: 'statusCode',
  );

  setUp(() {
    remoteDataSource = MockVideoRemoteDataSrc();
    repoImpl = VideoRepoImpl(remoteDataSource);
    registerFallbackValue(tVideo);
  });

  test('should be a subclass of [VideoRepo]', () {
    expect(repoImpl, isA<VideoRepo>());
  });

  group('addVideo', () {
    test(
      'should call the [RemoteDataSource.addVideo] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(() => remoteDataSource.addVideo(any()))
            .thenAnswer((_) async => Future.value());

        final result = await repoImpl.addVideo(tVideo);

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSource.addVideo(tVideo)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(() => remoteDataSource.addVideo(any())).thenThrow(tException);

        final result = await repoImpl.addVideo(tVideo);

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(() => remoteDataSource.addVideo(tVideo)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getVideos', () {
    test(
      'should call the [RemoteDataSource.getVideos] and complete '
      'successfully when the call to the Remote source is successful',
      () async {
        when(() => remoteDataSource.getVideos(any()))
            .thenAnswer((_) async => [tVideo]);

        final result = await repoImpl.getVideos('courseId');

        expect(result, isA<Right<dynamic, List<Video>>>());
        verify(() => remoteDataSource.getVideos('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the Remote '
      'source is unsuccessful',
      () async {
        when(() => remoteDataSource.getVideos(any())).thenThrow(tException);

        final result = await repoImpl.getVideos('courseId');

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
        verify(() => remoteDataSource.getVideos('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
