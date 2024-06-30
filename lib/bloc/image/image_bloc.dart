import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:img_loader/repository/image_repository.dart';
import 'package:img_loader/services/base_service.dart';
import 'package:img_loader/services/image_service.dart';

import 'image_data.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository _imageRepository;

  ImageBloc({required this.imageRepository})
      : _imageRepository = imageRepository,
        super(const ImageState()) {
    on<ImageLoadingStarted>(_processUrl);
  }

  final ImageRepository imageRepository;

  void _processUrl(
    ImageLoadingStarted event,
    Emitter<ImageState> emit,
  ) async {
    emit(state.copyWith(status: ImageStatus.loading));
    try {
      var image = await _imageRepository.fetchImage(event.url);
      image = ImageData(
        await ImageService.getGrayscale(
          imageBytes: image.bytes,
        ),
      );
      await imageRepository.saveImage(image, event.url);
      emit(
        state.copyWith(
          status: ImageStatus.success,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: ImageStatus.failure,
          exceptionMessage: e.message,
        ),
      );
    } on ClientException catch (e) {
      emit(
        state.copyWith(
            status: ImageStatus.failure,
            exceptionMessage: "${e.message}\nMaybe you using VPN?"),
      );
    }
  }
}
