import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/models/password_states.dart';

final paswordLengthNotifierProvider =
    StateNotifierProvider<PasswordLengthNotifer, double>(
  (ref) {
    return PasswordLengthNotifer(8);
  },
);

final paswordStateNotifierProvider =
    StateNotifierProvider<PasswordNotifier, PasswordStates>(
  (ref) {
    const initialState = PasswordStates(
      enableUpperCase: true,
      enableDigits: false,
      enableSymbols: false,
    );
    return PasswordNotifier(initialState);
  },
);

class PasswordNotifier extends StateNotifier<PasswordStates> {
  PasswordNotifier(PasswordStates state) : super(state);

  void toggleUpperCase() {
    PasswordStates currentState = state;

    state = currentState.copyWith(
      enableUpperCase: !currentState.enableUpperCase,
    );
  }

  void toggleSymbols() {
    PasswordStates currentState = state;

    state = currentState.copyWith(
      enableSymbols: !currentState.enableSymbols,
    );
  }

  void toggleDigits() {
    PasswordStates currentState = state;

    state = currentState.copyWith(
      enableDigits: !currentState.enableDigits,
    );
  }
}

class PasswordLengthNotifer extends StateNotifier<double> {
  PasswordLengthNotifer(double state) : super(state);

  void toggleState(double value) {
    state = value;
  }
}

final passwordGenratorProvider = StateProvider<String>(
  (ref) {
    final length = ref.watch(paswordLengthNotifierProvider);

    final isCharacter = ref.watch(paswordStateNotifierProvider).enableUpperCase;
    final isSpecial = ref.watch(paswordStateNotifierProvider).enableSymbols;
    final isNumbers = ref.watch(paswordStateNotifierProvider).enableDigits;
    print(isNumbers);

    String generatePassword() {
      const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
      const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      const number = '0123456789';
      const special = '@#%^*>\$@?/[]=+';

      String chars = "";
      if (isCharacter) chars += letterUpperCase;
      if (isCharacter) chars += letterLowerCase;
      if (isNumbers) chars += number;
      if (isSpecial) chars += special;

      if (chars.isEmpty) return 'Please select an option first';

      return List.generate(length.toInt(), (index) {
        final indexRandom = Random.secure().nextInt(chars.length);
        return chars[indexRandom];
      }).join('');
    }

    return generatePassword();
  },
);
