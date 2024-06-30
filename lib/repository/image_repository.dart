import 'dart:async';
import 'dart:io';

import 'package:img_loader/bloc/image/image_data.dart';
import 'package:img_loader/services/base_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRepository with BaseService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<ImageData> fetchImage(String url) async {
    final bytes = await getRequest(url: url);
    return ImageData(bytes);
  }

  Future<List<ImageData>> loadImages() async {
    List<ImageData> images = List.empty(growable: true);
    final paths = await _getSavedPaths();
    for (final path in paths) {
      var file = File(path);
      var imageBytes = await file.readAsBytes();
      images.add(ImageData(imageBytes));
    }
    return images;
  }

  Future<void> saveImage(ImageData image, String url) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File(path.join(directory.path, path.basename(url)));
    await file.writeAsBytes(image.bytes);
    await savePath(file.path);
  }

  Future<List<String>> loadPaths() async => _getSavedPaths();

  Future<void> savePath(String path) async {
    final paths = await _getSavedPaths();
    paths.add(path);
    await _updateSavedPaths(paths);
  }

  Future<List<String>> _getSavedPaths() async {
    var prefs = await _prefs;
    await prefs.reload();
    return prefs.getStringList('paths') ?? <String>[];
  }

  Future<void> _updateSavedPaths(List<String> updatedPaths) async {
    var prefs = await _prefs;
    await prefs.setStringList('paths', updatedPaths);
  }
}
