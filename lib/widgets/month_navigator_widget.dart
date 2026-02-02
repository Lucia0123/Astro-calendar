import 'package:calendar/providers.dart';
import 'package:calendar/widgets/month_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthNavigatorWidget extends ConsumerWidget {

  const MonthNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthNames = ref.watch(monthNameProvider);
    final textTheme = ref.watch(themeProvider).textTheme;
    final colorScheme = ref.watch(themeProvider).colorScheme;
    final month = ref.watch(monthProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
          ElevatedButton(
            onPressed: (){
              final monthWidget = ref.read(monthProvider);
              ref.read(monthProvider.notifier).state = MonthWidget(
                year: monthWidget.month == 1 ? monthWidget.year - 1 : monthWidget.year,
                month: monthWidget.month == 1 ? 12 : monthWidget.month - 1);
            },
          child: Icon(Icons.arrow_back, color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Text("${monthNames[month.month]} ${month.year}", style: textTheme.displayLarge?.copyWith(color: colorScheme.onPrimaryContainer)),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: (){
              final monthWidget = ref.read(monthProvider);
              ref.read(monthProvider.notifier).state = MonthWidget(
                year: monthWidget.month == 12 ? monthWidget.year + 1 : monthWidget.year,
                month: monthWidget.month == 12 ? 1 : monthWidget.month + 1);
            },
          child: Icon(Icons.arrow_forward, color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 20),
        month
      ],
    );
  }

}