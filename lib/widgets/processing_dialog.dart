part of '../ui/home_page.dart';

Widget _buildProcessingDialog() {
  return AlertDialog(
    title: BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) => _buildTitle(context, state),
    ),
    content: BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) => _buildContent(
        context,
        state,
        (text) => context.read<DialogBloc>().add(DialogInputChanged(text)),
      ),
    ),
    actions: [
      BlocBuilder<DialogBloc, DialogState>(
        builder: (context, state) => _buildActions(context, state),
      ),
    ],
  );
}

Widget _buildTitle(
  BuildContext context,
  DialogState state,
) {
  return Text(
    state.title!,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

Widget _buildContent(
  BuildContext context,
  DialogState state,
  Function(String) onUrlChanged,
) {
  switch (state.status) {
    case DialogStatus.success:
    case DialogStatus.failure:
      return Text(
        state.contentText!,
        style: Theme.of(context).textTheme.bodyLarge,
      );
    case DialogStatus.initial:
    case DialogStatus.validUrl:
    case DialogStatus.invalidUrl:
      return TextField(
        decoration: InputDecoration(
          hintText: "Image URL",
          border: const OutlineInputBorder(),
          errorText: (state.status == DialogStatus.invalidUrl)
              ? state.contentText
              : null,
        ),
        onChanged: onUrlChanged,
      );
    case DialogStatus.submitted:
      return const LinearProgressIndicator();
    default:
      return const SizedBox.shrink();
  }
}

Row _buildActions(
  BuildContext context,
  DialogState state,
) {
  switch (state.status) {
    case DialogStatus.success:
    case DialogStatus.failure:
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _closeButton(context),
        ],
      );
    case DialogStatus.invalidUrl:
    case DialogStatus.initial:
    case DialogStatus.validUrl:
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _closeButton(context),
          _submitButton(context, state),
        ],
      );
    default:
      return const Row(
        children: [],
      );
  }
}

TextButton _submitButton(BuildContext context, DialogState state) {
  return TextButton(
    onPressed: () {
      (state.status == DialogStatus.validUrl)
          ? context.read<DialogBloc>().add(DialogSubmitted(state.url!))
          : null;
    },
    child: const Text("Submit"),
  );
}

TextButton _closeButton(BuildContext context) {
  return TextButton(
    onPressed: () => Navigator.pop(context),
    child: const Text("Close"),
  );
}
