import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon23/features/app/shared/app.providers.dart';

class HackathonApp extends ConsumerWidget {
  const HackathonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoutes = ref.read(AppProviders.router);

    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
      ),
      builder: (_) {
        return PlatformApp.router(
          routeInformationProvider: appRoutes.router.routeInformationProvider,
          routeInformationParser: appRoutes.router.routeInformationParser,
          routerDelegate: appRoutes.router.routerDelegate,
          title: 'Hackathon 23',
          cupertino: (_, __) => CupertinoAppRouterData(
            theme: const CupertinoThemeData(
              brightness: Brightness.dark,
            ),
          ),
          material: (_, __) => MaterialAppRouterData(
            theme: ThemeData.dark(useMaterial3: true),
          ),
        );
      },
    );
  }
}
