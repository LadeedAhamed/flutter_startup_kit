import 'package:args/args.dart';
import 'package:flutter_startup_kit/src/commands/create_command.dart';

const String version = '1.0.0';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('create', CreateCommand.parser())
    ..addFlag('version', abbr: 'v', help: 'Print version');

  final results = parser.parse(arguments);

  if (results['version'] as bool) {
    print('flutter_startup_kit version: $version');
    return;
  }

  if (results.command == null) {
    print('Flutter Startup Kit CLI v$version');
    print('');
    print('Usage:');
    print('  dart run flutter_startup_kit create <project_name> [options]');
    print('');
    print('Commands:');
    print('  create  Scaffold a new Flutter project');
    print('');
    print('Options:');
    print('  -v, --version  Print version');
    print('');
    print('Run "dart run flutter_startup_kit create --help" for create options.');
    return;
  }

  final command = results.command!;
  switch (command.name) {
    case 'create':
      CreateCommand().execute(command);
      break;
  }
}
