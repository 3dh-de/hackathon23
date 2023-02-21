import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon23/features/app/domain/development_configuration.dart';
import 'package:hackathon23/features/app/shared/app_routes.dart';

import '../data/app.repository.impl.dart';
import '../domain/app.repository.dart';
import '../domain/configuration.dart';
import '../presentation/app.controller.dart';

class AppProviders {
  // Data

  // Domain
  static final Provider<AppRepository> appRepository =
      Provider((ref) => AppRepositoryImpl());

  static final Provider<Configuration> configuration = Provider(
    (ref) => DevelopmentConfiguration(),
  );

  // Presentation
  static final Provider<AppController> appController =
      Provider((ref) => AppController());

  static final Provider<AppRoutes> router = Provider((ref) => AppRoutes());
}
