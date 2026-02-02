import 'package:calendar/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextWidget extends ConsumerWidget{
  final Text text;

  const TextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider).colorScheme;

    return Container(
      alignment: AlignmentGeometry.center,
      width: 250,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black, width: 1)),
      padding: const EdgeInsets.all(8),
      child: text
    );
  }
  
}