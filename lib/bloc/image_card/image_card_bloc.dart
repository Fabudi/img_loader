import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'image_card_event.dart';

part 'image_card_state.dart';

class ImageCardBloc extends Bloc<ImageCardEvent, ImageCardLoaderState> {
  ImageCardBloc() : super(ImageCardInitial()) {
    on<LoadImage>(_loadImage);
  }

  void _loadImage(
    LoadImage event,
    Emitter<ImageCardLoaderState> emit,
  ) async {
    emit(ImageCardLoading());
    try {
      await precacheImage(event.imageProvider, event.context);
      emit(ImageCardLoaded());
    } catch (e) {
      emit(ImageCardError());
    }
  }
}
