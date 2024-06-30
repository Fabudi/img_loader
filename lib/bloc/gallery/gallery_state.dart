part of 'gallery_bloc.dart';

enum GalleryStatus { loading, failure, success, empty }

class GalleryState extends Equatable {
  const GalleryState({
    this.status = GalleryStatus.loading,
    this.images = const [],
    this.exceptionMessage,
  });

  final GalleryStatus status;
  final List<ImageData> images;
  final String? exceptionMessage;

  GalleryState copyWith({
    GalleryStatus? status,
    List<ImageData>? images,
    String? exceptionMessage,
  }) {
    return GalleryState(
      status: status ?? this.status,
      images: images ?? this.images,
      exceptionMessage: exceptionMessage ?? this.exceptionMessage,
    );
  }

  @override
  List<Object> get props => [status, images.hashCode];
}
