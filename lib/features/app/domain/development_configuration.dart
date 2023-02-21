import 'package:envied/envied.dart';

import 'configuration.dart';

part 'development_configuration.g.dart';

@Envied(path: '.env.dev', obfuscate: true)
class DevelopmentConfiguration implements Configuration {
  @override
  @EnviedField(varName: 'API_URL')
  String apiUrl = _DevelopmentConfiguration.apiUrl;
}
