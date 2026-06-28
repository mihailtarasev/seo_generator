import 'generation_context.dart';

Future<void> main() async {
  await GenerationContext(
    schemaPath: 'example/assets/schema.json',
    templatePath: 'example/assets/index.html',
    configPath: 'example/assets/config.json',
    arbDirectory: 'example/assets',
    outputDirectory: 'example/output',
  ).generate();
}
