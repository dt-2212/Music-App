import 'package:go_router/go_router.dart';
import 'package:music_app/ui/login/login_screen.dart';
import 'app.dart';

GoRouter appRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/app', builder: (context, state) => const App()),
    ],
  );
}
