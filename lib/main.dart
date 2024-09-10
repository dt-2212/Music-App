import 'package:flutter/material.dart';
import 'package:music_app/ui/go_router.dart';

void main() {
  runApp(const MusicApp());
}
class MusicApp extends StatelessWidget {

  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}