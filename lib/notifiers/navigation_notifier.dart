import 'package:flutter_riverpod/legacy.dart';

class NavigationNotifier extends StateNotifier<int> {

  NavigationNotifier(super.currentIndex);

  void setIndex(int index) {
    state = index;
  }
}