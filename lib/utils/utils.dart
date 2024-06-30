class Utils{
  static bool isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;
}