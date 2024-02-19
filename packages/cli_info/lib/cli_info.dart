/// A class to pack information about a Dart CLI application.
final class CliInfo {
  const CliInfo({
    required this.name,
    required this.description,
    required this.version,
  });

  final String name;
  final String description;
  final String version;
}
