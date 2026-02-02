import 'dart:math';

import 'package:calendar/pages/homepage.dart';
import 'package:calendar/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: colorScheme.primaryContainer,
        appBar: AppBar(
          title: Text(ref.watch(appNameProvider), style: textTheme.displaySmall?.copyWith(color: colorScheme.onPrimary)),
          backgroundColor: colorScheme.primary,
          actions: [ 
            IconButton(
              icon: const Icon(Icons.color_lens),
              color: colorScheme.onPrimary,
              hoverColor: colorScheme.primaryContainer,
              highlightColor: colorScheme.onPrimaryContainer,
              onPressed: () {
                // cambio il colore del seed:
                final colors = [Colors.blue, Colors.red, Colors.purple, Colors.orange, Colors.green, Colors.yellow, Colors.indigo];
                final newColors = colors
                  .where((c) => c != ref.read(seedColorProvider)).toList();

                // chose new color randomly
                final randomIndex = Random().nextInt(newColors.length);
                final chosenColor = newColors[randomIndex];
                ref.read(seedColorProvider.notifier).changeSeedColor(chosenColor);
              },
            ),
      ],
          ),
        body: Homepage(),
      ),
    );
  }
}
