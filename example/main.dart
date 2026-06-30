import 'package:seo_generator/framework/seo_generator.dart';

Future<void> main() async {
  await GenerationContext(
    schemaPath: 'example/assets/schema.json',
    templatePath: 'example/assets/template/index.html',
    configPath: 'example/assets/config.json',
    localeDirectory: 'example/assets/locales/json',
    localeFormat: '.json',
    outputDirectory: 'example/output',
  ).generate();
}
