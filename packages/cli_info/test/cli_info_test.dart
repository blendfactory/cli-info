import 'package:cli_info/cli_info.dart';
import 'package:test/test.dart';

void main() {
  const name = 'cli_info';
  const description =
      'A package that provides a class to pack information about a Dart CLI application.';
  const version = '1.0.0';

  const cliInfo = CliInfo(
    name: name,
    description: description,
    version: version,
  );

  test('cli_info Test', () {
    expect(cliInfo.name, name);
    expect(cliInfo.description, description);
    expect(cliInfo.version, version);
  });
}
