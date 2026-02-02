import 'dart:ui';

import 'package:flutter_riverpod/legacy.dart';

class SeedColorNotifier extends StateNotifier<Color> {
  SeedColorNotifier(super.initialColor);

  void changeSeedColor(Color newColor) {
    state = newColor;
  }
}