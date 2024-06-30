part of 'dialog_bloc.dart';

sealed class DialogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DialogOpened extends DialogEvent {}

final class DialogInputChanged extends DialogEvent {
  final String url;

  DialogInputChanged(this.url);

  @override
  List<Object?> get props => [url];
}

final class DialogSubmitted extends DialogEvent {
  final String url;

  DialogSubmitted(this.url);

  @override
  List<Object?> get props => [url];
}

final class DialogCompleted extends DialogEvent {
  final bool isSuccess;
  final String status;
  final String message;

  DialogCompleted(
    this.isSuccess,
    this.status,
    this.message,
  );

  @override
  List<Object?> get props => [
        isSuccess,
        status,
        message,
      ];
}
