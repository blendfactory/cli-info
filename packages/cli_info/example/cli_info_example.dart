import 'package:cli_info/cli_info.dart';

void main() {
  const cliInfo = CliInfo(
    name: 'cli_info',
    description:
        'A package that provides a class to pack information about a Dart CLI application.',
    version: '1.0.0',
  );
  final text = '''
CLI Info:
- name: ${cliInfo.name}
- description: ${cliInfo.description}
- version: ${cliInfo.version}''';
  print(text);
}
