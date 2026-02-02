import 'package:calendar/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DayPage extends ConsumerWidget{

  const DayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Creating DayPage");
    final colorScheme = ref.watch(themeProvider).colorScheme;
    final textTheme = ref.watch(themeProvider).textTheme;
    final monthNames = ref.watch(monthNameProvider);
    final date = ref.watch(dateProvider);
    final navigationIndex = ref.watch(indexProvider);
    final content = ref.watch(activeContentProvider);

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text("Details about ${date.day} ${monthNames[date.month]} ${date.year}", style: textTheme.displaySmall?.copyWith(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: (index){
          ref.read(indexProvider.notifier).setIndex(index);
        },
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimaryContainer,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.linear_scale_rounded), label: "Moon phase"),
          BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: "Rise and set times"),
        ],
      ),
      body: content);
  }

  // Obiettivo: mostrare il grado della luna per quel giorno
}