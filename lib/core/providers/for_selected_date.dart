import 'package:flutter/material.dart';

class SelectedItemProvider with ChangeNotifier {
  DateTime _selectedDate;

  SelectedItemProvider(this._selectedDate);

  DateTime get getSelected => _selectedDate;

  void setSelected(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}