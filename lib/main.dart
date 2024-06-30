import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:img_loader/bloc/dialog/dialog_bloc.dart';
import 'package:img_loader/bloc/image/image_bloc.dart';
import 'package:img_loader/repository/image_repository.dart';
import 'package:img_loader/ui/home_page.dart';

import 'bloc/gallery/gallery_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ImageRepository _imageRepository;

  @override
  void initState() {
    super.initState();
    _imageRepository = ImageRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _imageRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ImageBloc(imageRepository: _imageRepository),
          ),
          BlocProvider(
            create: (_) => DialogBloc(),
          ),
          BlocProvider(
            create: (_) => GalleryBloc(imageRepository: _imageRepository)
              ..add(GalleryInitial()),
          ),
          BlocListener<ImageBloc, ImageState>(
            listener: (context, state) {
              if (state.status == ImageStatus.success) {
                context.read<GalleryBloc>().add(GalleryUpdated());
                context.read<DialogBloc>().add(
                      DialogCompleted(
                        true,
                        "Completed",
                        "Image has been downloaded and processed",
                      ),
                    );
              }
              if (state.status == ImageStatus.failure) {
                context.read<DialogBloc>().add(
                      DialogCompleted(
                        true,
                        "Oops...",
                        state.exceptionMessage!,
                      ),
                    );
              }
            },
          ),
          BlocListener<DialogBloc, DialogState>(
            listener: (context, state) {
              if (state.status == DialogStatus.submitted) {
                context.read<ImageBloc>().add(
                      ImageLoadingStarted(state.url!),
                    );
              }
            },
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
        primarySwatch: Colors.blue,
      ),
    );
  }
}