import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:img_loader/bloc/dialog/dialog_bloc.dart';
import 'package:img_loader/bloc/gallery/gallery_bloc.dart';
import 'package:img_loader/widgets/image_card.dart';

part '../widgets/gallery_view.dart';

part '../widgets/processing_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Loader",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) => _buildGalleryView(state),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<DialogBloc>().add(DialogOpened());
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => _buildProcessingDialog(),
          );
        },
      ),
    );
  }
}
