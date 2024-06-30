part of 'image_bloc.dart';

enum ImageStatus {
  idle,
  loading,
  success,
  failure,
  invalidUrl,
  emptyUrl,
  validUrl,
}

class ImageState extends Equatable {
  const ImageState({
    this.status = ImageStatus.idle,
    this.imageData,
    this.inputUrl,
    this.exceptionMessage,
  });

  final ImageStatus status;
  final ImageData? imageData;
  final String? inputUrl;
  final String? exceptionMessage;

  ImageState copyWith({
    ImageStatus? status,
    ImageData? imageData,
    String? inputUrl,
    String? exceptionMessage,
  }) {
    return ImageState(
      status: status ?? this.status,
      imageData: imageData ?? this.imageData,
      inputUrl: inputUrl ?? this.inputUrl,
      exceptionMessage: exceptionMessage ?? this.exceptionMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        if (imageData != null) imageData!,
        if (inputUrl != null) inputUrl!,
      ];
}
