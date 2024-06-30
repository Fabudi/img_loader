part of 'image_card_bloc.dart';

abstract class ImageCardLoaderState extends Equatable {
  const ImageCardLoaderState();

  @override
  List<Object> get props => [];
}

class ImageCardInitial extends ImageCardLoaderState {}

class ImageCardLoading extends ImageCardLoaderState {}

class ImageCardLoaded extends ImageCardLoaderState {}

class ImageCardError extends ImageCardLoaderState {}