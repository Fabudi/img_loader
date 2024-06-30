part of 'image_card_bloc.dart';

abstract class ImageCardEvent extends Equatable {
  const ImageCardEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends ImageCardEvent {
  final ImageProvider imageProvider;
  final BuildContext context;

  const LoadImage(this.imageProvider, this.context);

  @override
  List<Object> get props => [imageProvider, context];
}