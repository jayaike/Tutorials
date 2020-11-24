import 'package:flutter/material.dart';
import 'package:listanimations/state/klass.dart';

class KlassListState extends ChangeNotifier {
  int _selectedKlassId;
  List<KlassState> _klasses;

  // Constructor
  KlassListState() {
    this._klasses = List.generate(6, (index) => KlassState(index));
    this.selectedKlassId = 0;
  }

  // Getters
  int get selectedKlassId => this._selectedKlassId;
  List<KlassState> get klasses => this._klasses;
  KlassState get selectedKlass => this._klasses
      .firstWhere((klass) => klass.id == this._selectedKlassId, orElse: () => null);

  // Setters
  set selectedKlassId(int newValue) {
    this._selectedKlassId = newValue;
    notifyListeners();
  }

  set klasses(List<KlassState> newValue) {
    this._klasses = newValue;
    notifyListeners();
  }
}


