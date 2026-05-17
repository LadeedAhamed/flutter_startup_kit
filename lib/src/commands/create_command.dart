import 'dart:io';
import 'package:args/args.dart';
import '../template_processor.dart';

class CreateCommand {
  static ArgParser parser() {
    return ArgParser()
      ..addOption('org',
        abbr: 'o',
        defaultsTo: 'com.example',
        help: 'Organization name (e.g. com.mycompany)',
      )
      ..addOption('description',
        abbr: 'd',
        defaultsTo: 'A Flutter application',
        help: 'Project description',
      )
      ..addOption('output',
        abbr: 'O',
        help: 'Output directory (default: ./<project_name>)',
      );
  }

  void execute(ArgResults results) {
    final args = results.rest;
    if (args.isEmpty) {
      print('Error: Missing project name.');
      print('Usage: dart run flutter_startup_kit create <project_name> [options]');
      exit(1);
    }

    final projectName = args.first;
    final orgName = results['org'] as String;
    final description = results['description'] as String;
    final outputDir = results['output'] as String? ?? './$projectName';

    final targetDir = Directory(outputDir);
    if (targetDir.existsSync()) {
      print('Error: Directory "$outputDir" already exists.');
      exit(1);
    }

    print('Creating $projectName...');
    print('  Organization: $orgName');
    print('  Description:  $description');
    print('  Output:       $outputDir');

    final templateDir = _findTemplateDirectory();
    if (templateDir == null) {
      print('Error: Template directory not found.');
      exit(1);
    }

    final processor = TemplateProcessor(
      templateDir: templateDir,
      targetDir: targetDir,
      projectName: projectName,
      orgName: orgName,
      description: description,
    );

    try {
      processor.process();
      print('');
      print('✅ Project created successfully!');
      print('');
      print('Next steps:');
      print('  cd $projectName');
      print('  flutter pub get');
      print('  flutter run --flavor dev -t lib/main_dev.dart');
      print('');
    } catch (e) {
      print('Error: $e');
      exit(1);
    }
  }

  Directory? _findTemplateDirectory() {
    // Try relative to the package root (works for both source and pub cache)
    final script = Platform.script.toFilePath();
    var dir = Directory(script).parent;
    for (var i = 0; i < 4; i++) {
      final candidate = Directory('${dir.path}/templates/flutter_app');
      if (candidate.existsSync()) return candidate;
      dir = dir.parent;
    }

    return null;
  }
}
