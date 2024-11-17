import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windrop/core/presentation/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FileAirDropApp(),
    ),
  );
}

