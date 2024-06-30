import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/utils.dart';

part 'dialog_event.dart';

part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc() : super(const DialogState()) {
    on<DialogOpened>(_openDialog);
    on<DialogInputChanged>(_validateUrl);
    on<DialogSubmitted>(_submitUrl);
    on<DialogCompleted>(_closeDialog);
  }

  void _openDialog(
    DialogOpened event,
    Emitter<DialogState> emit,
  ) {
    emit(state.copyWith(
      status: DialogStatus.initial,
      url: "",
      title: "Enter image URL",
      contentText: "Invalid URL",
    ));
  }

  void _validateUrl(
    DialogInputChanged event,
    Emitter<DialogState> emit,
  ) {
    if (event.url.isEmpty) {
      return emit(state.copyWith(
        status: DialogStatus.initial,
        url: "",
        title: "Enter image URL",
        contentText: "Invalid URL",
      ));
    }
    if (Utils.isValidUrl(event.url)) {
      return emit(state.copyWith(
        status: DialogStatus.validUrl,
        url: event.url,
        title: "Enter image URL",
        contentText: "Invalid URL",
      ));
    }
    return emit(
      state.copyWith(
        status: DialogStatus.invalidUrl,
        title: "Enter image URL",
        contentText: "Invalid URL",
      ),
    );
  }

  void _submitUrl(
    DialogSubmitted event,
    Emitter<DialogState> emit,
  ) {
    emit(
      state.copyWith(
        status: DialogStatus.submitted,
        url: event.url,
        title: "Downloading image",
      ),
    );
  }

  void _closeDialog(
    DialogCompleted event,
    Emitter<DialogState> emit,
  ) {
    emit(
      state.copyWith(
        status: DialogStatus.success,
        title: event.status,
        contentText: event.message,
      ),
    );
  }
}
