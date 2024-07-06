import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';

class AddVideo extends UseCaseWithParams<void, Video> {
  AddVideo(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<void> call(Video params) => _repo.addVideo(params);
}
