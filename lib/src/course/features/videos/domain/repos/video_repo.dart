import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';

abstract class VideoRepo {
  const VideoRepo();

  // We could make this a stream, but for sakes of tutorials,
  // we'll keep it simple
  ResultFuture<List<Video>> getVideos(String courseId);

  ResultFuture<void> addVideo(Video video);
}
