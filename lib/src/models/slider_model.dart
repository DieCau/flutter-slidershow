import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double _currentPage = 0;

  // Hacer un Geeter
  double get currentPage => _currentPage;

  // Hacer un Seeter
  set currentPage(double currentPage) {
    _currentPage = currentPage;
    // Notifica a todos los widgets que esten escuchando el cambio del valor "double _currentPage = 0"
    notifyListeners();
  }
}
