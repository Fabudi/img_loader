import 'dart:typed_data';

import 'package:image/image.dart';

mixin ImageService {
  static Future<Uint8List> getGrayscale({required Uint8List imageBytes}) async {
    return (await (Command()
              ..decodeImage(imageBytes)
              ..grayscale()
              ..encodeJpg())
            .executeThread())
        .outputBytes!;
  }
}
