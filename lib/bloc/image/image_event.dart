part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImageInitial extends ImageEvent {}

final class ImageLoadingStarted extends ImageEvent {
  final String url;

  ImageLoadingStarted(this.url);

  @override
  List<Object?> get props => [url];
}

final class ImageFilteringStarted extends ImageEvent {
  final ImageData imageData;

  ImageFilteringStarted(this.imageData);

  @override
  List<Object?> get props => [imageData];
}

final class ImageLoaded extends ImageEvent {
  final ImageData imageData;

  ImageLoaded(this.imageData);

  @override
  List<Object?> get props => [imageData];
}

final class ImageFiltered extends ImageEvent {
  final ImageData imageData;

  ImageFiltered(this.imageData);

  @override
  List<Object?> get props => [imageData];
}

final class ImageSavingRequested extends ImageEvent {
  final ImageData imageData;

  ImageSavingRequested(this.imageData);

  @override
  List<Object?> get props => [imageData];
}

final class ImageSaved extends ImageEvent {}
