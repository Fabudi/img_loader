part of '../ui/home_page.dart';

Widget _buildGalleryView(GalleryState state) {
  switch (state.status) {
    case GalleryStatus.failure:
      return Builder(
        builder: (context) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              "Something went wrong.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      );
    case GalleryStatus.loading:
    case GalleryStatus.success:
      return GridView.builder(
        cacheExtent: 10000,
        itemCount: state.images.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return ImageCard(
            key: Key(index.toString()),
            imageProvider: MemoryImage(state.images[index].bytes),
          );
        },
      );
    case GalleryStatus.empty:
      return Builder(
        builder: (context) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              "There are no images. Add some via '+' button",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      );
  }
}
