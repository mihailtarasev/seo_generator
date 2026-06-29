import 'package:seo_generator/framework/seo_generator.dart';

Future<void> main() async {
  await GenerationContext(
    schemaPath: 'example/assets/schema.json',
    templatePath: 'example/assets/index.html',
    arbDirectory: 'example/assets',
    outputDirectory: 'example/output',
  ).generate();
}
