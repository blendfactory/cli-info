[![Pub Version](https://badgen.net/pub/v/cli_info_builder)](https://pub.dev/packages/cli_info_builder/)
[![Dart SDK Version](https://badgen.net/pub/sdk-version/cli_info_builder)](https://pub.dev/packages/cli_info_builder/)
[![Pub popularity](https://badgen.net/pub/popularity/cli_info_builder)](https://pub.dev/packages/cli_info_builder/score)

# cli_info_builder

A package that provides a builder to generate a class to pack information about a Dart CLI application.

## Usage

1. Add the necessary dependencies:

   ```console
   dart pub add cli_info
   dart pub add dev:build_runner
   dart pub add dev:cli_info_builder
   ```

2. Run a build:

   ```console
   dart pub run build_runner build
   ```

3. `lib/gen/cli_info.dart` will be generated with content:

   ```dart
   // coverage:ignore-file
   // GENERATED CODE - DO NOT MODIFY BY HAND
   // ignore_for_file: type=lint
   // ignore_for_file: lines_longer_than_80_chars

   import 'package:cli_info/cli_info.dart';

   const cliInfo = CliInfo(
       //...
   );
   ```

### Optional

To change the index of the target executable name or the path of the generated file, create a `build.yaml` in the root of the package and write the following:

```yaml
targets:
  $default:
    builders:
      cli_info_builder:
        options:
          executables-index: 1 # default is 0
          output: "lib/gen/info.dart" # default is "lib/gen/cli_info.dart"
```

## See also

- [build](https://pub.dev/packages/build)
- [build_config](https://pub.dev/packages/build_config)
- [build_runner](https://pub.dev/packages/build_runner)
- [cli_info](https://pub.dev/packages/cli_info)
