import 'package:flutter/material.dart';
import 'package:windrop/core/presentation/views/home_screen.dart';

class FileAirDropApp extends StatelessWidget {
  const FileAirDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File AirDrop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
