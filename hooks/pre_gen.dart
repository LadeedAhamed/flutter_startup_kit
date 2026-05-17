import 'package:mason/mason.dart';

void run(HookContext context) {
  final name = context.vars['name'];
  final orgName = context.vars['org_name'] ?? 'com.example';
  final description = context.vars['description'] ?? 'A Flutter application';

  context.logger.info('Generating $name...');
  context.logger.info('Organization: $orgName');
  context.logger.info('Description: $description');
}
