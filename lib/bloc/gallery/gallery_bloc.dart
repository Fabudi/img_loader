
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:img_loader/bloc/image/image_data.dart';
import 'package:img_loader/repository/image_repository.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final ImageRepository _imageRepository;

  GalleryBloc({required this.imageRepository})
      : _imageRepository = imageRepository,
        super(const GalleryState()) {
    on<GalleryInitial>(_loadImages);
    on<GalleryUpdated>(_updateImages);
  }

  final ImageRepository imageRepository;

  void _updateImages(
    GalleryUpdated event,
    Emitter<GalleryState> emit,
  ) async {
    var image = (await _imageRepository.loadImages()).last;
    var images = <ImageData>[];
    if(state.images.isEmpty){
      images = await _imageRepository.loadImages();
    }else{
      images = state.images;
      images.add(image);
    }
    emit(state.copyWith(
      status: GalleryStatus.loading
    ));
    emit(state.copyWith(
      status: GalleryStatus.success,
      images: images,
    ));
  }

  void _loadImages(
    GalleryInitial event,
    Emitter<GalleryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: GalleryStatus.loading,
      ),
    );

    try {
      var images = await _imageRepository.loadImages();
      if(images.isEmpty){
        return emit(
          state.copyWith(
            status: GalleryStatus.empty
          ),
        );
      }
      emit(
        state.copyWith(
          status: GalleryStatus.success,
          images: images,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GalleryStatus.failure,
          exceptionMessage: "Error $e",
        ),
      );
    }
  }
}
