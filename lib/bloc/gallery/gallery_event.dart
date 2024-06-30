part of 'gallery_bloc.dart';

sealed class GalleryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GalleryInitial extends GalleryEvent {}
final class GalleryUpdated extends GalleryEvent {}

final class GalleryLoadRequested extends GalleryEvent {
  final List<ImageData> images;

  @override
  List<Object?> get props => [images];

  GalleryLoadRequested(this.images);
}
