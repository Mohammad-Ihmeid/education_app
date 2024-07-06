import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';

class GetVideos extends UseCaseWithParams<List<Video>, String> {
  GetVideos(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call(String params) => _repo.getVideos(params);
}
