import 'dart:io';

class TemplateProcessor {
  final Directory templateDir;
  final Directory targetDir;
  final String projectName;
  final String orgName;
  final String description;

  TemplateProcessor({
    required this.templateDir,
    required this.targetDir,
    required this.projectName,
    required this.orgName,
    required this.description,
  });

  void process() {
    _copyDirectory(templateDir, targetDir);
    _processFiles(targetDir);
  }

  void _copyDirectory(Directory source, Directory destination) {
    destination.createSync(recursive: true);

    for (final entity in source.listSync()) {
      final basename = entity.path.split(Platform.pathSeparator).last;

      if (basename.startsWith('.')) continue;

      if (entity is File) {
        final content = entity.readAsStringSync();
        final processed = _applyVariables(content);
        final targetPath = '${destination.path}${Platform.pathSeparator}$basename';

        File(targetPath).writeAsStringSync(processed);
      } else if (entity is Directory) {
        final targetSubDir = Directory(
          '${destination.path}${Platform.pathSeparator}$basename',
        );
        _copyDirectory(entity, targetSubDir);
      }
    }
  }

  void _processFiles(Directory directory) {
    for (final entity in directory.listSync()) {
      if (entity is File) {
        final content = entity.readAsStringSync();
        final processed = _applyVariables(content);
        entity.writeAsStringSync(processed);
      } else if (entity is Directory) {
        _processFiles(entity);
      }
    }
  }

  String _applyVariables(String content) {
    final projectSnake = _toSnakeCase(projectName);
    return content
        .replaceAll('{{name.snakeCase()}}', projectSnake)
        .replaceAll('{{name.pascalCase()}}', _toPascalCase(projectName))
        .replaceAll('{{name.camelCase()}}', _toCamelCase(projectName))
        .replaceAll('{{name}}', projectSnake)
        .replaceAll('{{description}}', description)
        .replaceAll('{{org_name}}', orgName)
        .replaceAll('package:flutter_startup_kit/', 'package:$projectSnake/');
  }

  String _toSnakeCase(String name) {
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').toLowerCase();
  }

  String _toPascalCase(String name) {
    return name
        .split(RegExp(r'[^a-zA-Z0-9]'))
        .where((s) => s.isNotEmpty)
        .map((s) => '${s[0].toUpperCase()}${s.substring(1)}')
        .join();
  }

  String _toCamelCase(String name) {
    final pascal = _toPascalCase(name);
    if (pascal.isEmpty) return '';
    return '${pascal[0].toLowerCase()}${pascal.substring(1)}';
  }
}
