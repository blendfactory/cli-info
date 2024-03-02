import 'dart:async';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:yaml/yaml.dart';

Builder builder(BuilderOptions options) => CliInfoBuilder(options);

final _versionRegExp = RegExp(
  r'^'
  r'(\d+)\.(\d+)\.(\d+)' // Version number.
  r'(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Pre-release.
  r'(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Build.
  r'$',
);

class CliInfoBuilder implements Builder {
  CliInfoBuilder(BuilderOptions options)
      : _executablesIndex = options.config['executables-index'] ?? 0,
        _output = options.config['output'] ?? 'lib/gen/cli_info.dart';

  final int _executablesIndex;
  final String _output;

  @override
  Map<String, List<String>> get buildExtensions => {
        'pubspec.yaml': [
          _output,
        ]
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId;
    final content = await buildStep.readAsString(assetId);
    final pubspec = loadYaml(content) as YamlMap?;
    if (pubspec == null) {
      log.warning('Could not parse pubspec.yaml at $assetId');
      return;
    }

    final name = () {
      // https://dart.dev/tools/pub/pubspec#executables
      final executables = pubspec['executables'] as YamlMap?;
      final executable =
          executables?.keys.elementAtOrNull(_executablesIndex) as String?;
      if (executable != null && executable.isNotEmpty) {
        return executable;
      }
      return pubspec['name'] as String?;
    }();
    if (name == null || name.isEmpty) {
      log.warning('Could not determine package name from $assetId');
      return;
    }

    final description = pubspec['description'] as String?;
    if (description == null || description.isEmpty) {
      log.warning('Could not determine package description from $assetId');
      return;
    }

    final version = pubspec['version'] as String?;
    if (version == null || version.isEmpty) {
      log.warning('Could not determine package version from $assetId');
      return;
    }
    if (!_versionRegExp.hasMatch(version)) {
      log.warning('Invalid version format in $assetId: $version');
      return;
    }

    final outputContents = """
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:cli_info/cli_info.dart';

const cliInfo = CliInfo(
  name: '$name',
  description: '''$description''',
  version: '$version',
);
""";
    final formattedOutputContents = DartFormatter().format(outputContents);

    await buildStep.writeAsString(
      buildStep.allowedOutputs.single,
      formattedOutputContents,
    );
  }
}
