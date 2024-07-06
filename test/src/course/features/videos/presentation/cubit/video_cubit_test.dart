import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get_videos.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddVideo extends Mock implements AddVideo {}

class MockGetVideos extends Mock implements GetVideos {}

void main() {
  late AddVideo addVideo;
  late GetVideos getVideos;
  late VideoCubit cubit;

  final tVideo = VideoModel.empty();

  setUp(() {
    addVideo = MockAddVideo();
    getVideos = MockGetVideos();
    cubit = VideoCubit(addVideo: addVideo, getVideos: getVideos);
    registerFallbackValue(tVideo);
  });

  tearDown(() => cubit.close());

  test('initial state should be [VideoInitial]', () async {
    expect(cubit.state, const VideoInitial());
  });

  group('addCourse', () {
    blocTest<VideoCubit, VideoState>(
      'emits [AddingVideo, VideoAdded] when addVideo is called',
      build: () {
        when(() => addVideo(any())).thenAnswer((_) async => const Right(null));

        return cubit;
      },
      act: (cubit) => cubit.addVideo(tVideo),
      expect: () => <VideoState>[
        const AddingVideo(),
        const VideoAdded(),
      ],
      verify: (_) {
        verify(() => addVideo(tVideo)).called(1);
        verifyNoMoreInteractions(addVideo);
      },
    );

    blocTest<VideoCubit, VideoState>(
      'emits [AddingVideo, VideoError] when addVideo is called',
      build: () {
        when(() => addVideo(any())).thenAnswer(
          (_) async =>
              Left(ServerFailure(message: 'Server Failure', statusCode: 500)),
        );

        return cubit;
      },
      act: (cubit) => cubit.addVideo(tVideo),
      expect: () => const [
        AddingVideo(),
        VideoError('500 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => addVideo(tVideo)).called(1);
        verifyNoMoreInteractions(addVideo);
      },
    );
  });

  group('getCourses', () {
    blocTest<VideoCubit, VideoState>(
      'emits [LoadingVideos, VideosLoaded] when getVideos is called',
      build: () {
        when(() => getVideos(any())).thenAnswer((_) async => Right([tVideo]));

        return cubit;
      },
      act: (cubit) => cubit.getVideos('courseId'),
      expect: () => <VideoState>[
        const LoadingVideos(),
        VideosLoaded([tVideo]),
      ],
      verify: (_) {
        verify(() => getVideos('courseId')).called(1);
        verifyNoMoreInteractions(getVideos);
      },
    );

    blocTest<VideoCubit, VideoState>(
      'emits [LoadingVideos, VideoError] when getVideos is called',
      build: () {
        when(() => getVideos(any())).thenAnswer(
          (_) async =>
              Left(ServerFailure(message: 'Server Failure', statusCode: 500)),
        );

        return cubit;
      },
      act: (cubit) => cubit.getVideos('courseId'),
      expect: () => const [
        LoadingVideos(),
        VideoError('500 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => getVideos('courseId')).called(1);
        verifyNoMoreInteractions(getVideos);
      },
    );
  });
}
