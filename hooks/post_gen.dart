import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final name = context.vars['name'];
  final logger = context.logger;

  logger.info('Running flutter pub get...');
  final result = Process.runSync('flutter', ['pub', 'get'],
      workingDirectory: Directory.current.path);

  if (result.exitCode == 0) {
    logger.success('$name is ready!');
    logger.info('Run: cd ${name} && flutter run --flavor dev -t lib/main_dev.dart');
  } else {
    logger.err('Failed to install dependencies');
    logger.err(result.stderr.toString());
  }
}
