import 'package:build/build.dart';
import 'package:cli_info_builder/cli_info_builder.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() async {
  test('CliInfoBuilder test', () async {
    final builder = CliInfoBuilder(
      BuilderOptions(
        {
          "executables-index": 1,
          "output": "lib/gen/info.dart",
        },
      ),
    );

    const inputContent = '''
name: example
description: An example CLI application using cli_info_builder.
version: 1.0.0-alpha
publish_to: none

environment:
  sdk: ^3.3.0

executables:
  demo:
  eg: example

dependencies:
  cli_info:
    path: ../../cli_info

dev_dependencies:
  cli_info_builder:
    path: ..
  build_runner: ^2.4.8
''';

    const outputContent = """
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:cli_info/cli_info.dart';

const cliInfo = CliInfo(
  name: 'eg',
  description: '''An example CLI application using cli_info_builder.''',
  version: '1.0.0-alpha',
);
""";
    await testBuilder(
      builder,
      {
        'example|pubspec.yaml': inputContent,
      },
      reader: InMemoryAssetReader(rootPackage: 'example'),
      writer: InMemoryAssetWriter(),
      outputs: <String, String>{
        'example|lib/gen/info.dart': outputContent,
      },
      onLog: print,
    );
  });
}
