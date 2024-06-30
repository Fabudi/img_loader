import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/image_card/image_card_bloc.dart';

class ImageCard extends StatefulWidget {
  final ImageProvider imageProvider;

  const ImageCard({super.key, required this.imageProvider});

  @override
  ImageCardState createState() => ImageCardState();
}

class ImageCardState extends State<ImageCard> {
  late final ImageCardBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ImageCardBloc();
    _bloc.add(LoadImage(widget.imageProvider, context));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCardBloc, ImageCardLoaderState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is ImageCardLoaded) {
          return SizedBox(
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image(
                  image: widget.imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 90,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: state is ImageCardLoading,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    // Placeholder while loading or on error
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
