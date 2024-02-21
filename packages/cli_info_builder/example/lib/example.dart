import 'package:example/gen/info.dart';

void printCliInfo() {
  final text = '''
CLI Information:
- name: ${cliInfo.name}
- description: ${cliInfo.description}
- version: ${cliInfo.version}
''';
  print(text);
}
