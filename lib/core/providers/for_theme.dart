import 'package:flutter/material.dart';
import '/app/app.dart';

class ThemeProvider with ChangeNotifier {
  MyTheme _currentTheme = MyTheme.dark;
  MyGradient _currentGradient = MyGradient.galaxy;
  
  ThemeData get themeData => AppTheme.currTheme(_currentTheme)!;
  List<Color> get gradientData => AppTheme.currGrade(_currentGradient)!;

  bool get isDark => _currentTheme == MyTheme.dark;
  bool get isGalaxy => _currentGradient == MyGradient.galaxy;

  int get currentCombination {
    if (isDark) {
      return (isGalaxy) ? 1 : 2;
    }
    return (isGalaxy) ? 3 : 4;
  }

  void setCombination(int combination) {
    if (combination < 1 || combination > 4) return;

    switch (combination) {
      case 1:
        _currentTheme = MyTheme.dark;
        _currentGradient = MyGradient.galaxy;
        break;
      case 2:
        _currentTheme = MyTheme.dark;
        _currentGradient = MyGradient.neon;
        break;
      case 3:
        _currentTheme = MyTheme.light;
        _currentGradient = MyGradient.galaxy;
        break;
      case 4:
        _currentTheme = MyTheme.light;
        _currentGradient = MyGradient.neon;
        break;
    }

    notifyListeners();
  }

  void toggleNext() {
    final nextCombination = currentCombination % 4 + 1;
    setCombination(nextCombination);
  }
}
