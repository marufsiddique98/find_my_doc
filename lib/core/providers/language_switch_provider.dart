import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageSwitchProvider = StateNotifierProvider.autoDispose<LanguageSwitchNotifier, bool>(
      (ref) => LanguageSwitchNotifier(),
);

class LanguageSwitchNotifier extends StateNotifier<bool> {
  LanguageSwitchNotifier() : super(true);

  void onChange(bool val) {
    state = val;
  }
}
