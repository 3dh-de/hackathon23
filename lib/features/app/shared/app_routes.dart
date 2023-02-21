import 'package:go_router/go_router.dart';
import 'package:hackathon23/features/map/presentation/map.page.dart';

class AppRoutes {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (_, __) => MapPage(),
          ),
        ],
      );
}
