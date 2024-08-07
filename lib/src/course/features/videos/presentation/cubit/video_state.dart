part of 'video_cubit.dart';

sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class AddingVideo extends VideoState {
  const AddingVideo();
}

class VideoAdded extends VideoState {
  const VideoAdded();
}

class LoadingVideos extends VideoState {
  const LoadingVideos();
}

class VideosLoaded extends VideoState {
  const VideosLoaded(this.videos);

  final List<Video> videos;

  @override
  List<Object> get props => [videos];
}

class VideoError extends VideoState {
  const VideoError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
