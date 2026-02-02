import 'package:calendar/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeekdayLabel extends ConsumerWidget {

  final String day;

  const WeekdayLabel(this.day, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = ref.watch(themeProvider).textTheme;
    final colorScheme = ref.watch(themeProvider).colorScheme;

    return Flexible(
      child: Container(
        margin: EdgeInsets.all(3),
        width: 85,
        child: Center(
          child: Text(day, style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onPrimary,
          )),
        ),
      ),
    );
  }
}