part of 'dialog_bloc.dart';

enum DialogStatus {
  initial,
  loading,
  submitted,
  failure,
  success,
  invalidUrl,
  validUrl,
}

class DialogState extends Equatable {
  const DialogState({
    this.status = DialogStatus.initial,
    this.url,
    this.title,
    this.contentText
  });

  final DialogStatus status;
  final String? url;
  final String? title;
  final String? contentText;

  DialogState copyWith({
    DialogStatus? status,
    String? url,
    String? title,
    String? contentText,
  }) {
    return DialogState(
      status: status ?? this.status,
      url: url ?? this.url,
      title: title ?? this.title,
      contentText: contentText ?? this.contentText,
    );
  }

  @override
  List<Object> get props => [
        status,
        if (url != null) url!,
      ];
}
