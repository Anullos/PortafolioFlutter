import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafesProvider extends ChangeNotifier {
  bool _cambio = false;

  get cambio {
    return this._cambio;
  }

  set cambio(bool cambio) {
    this._cambio = cambio;
    notifyListeners();
  }

  int _paginaActual = 0;

  get pagina {
    return this._paginaActual;
  }

  set pagina(int index) {
    this._paginaActual = index;
    notifyListeners();
  }

  static CafesProvider of(BuildContext context) =>
      Provider.of<CafesProvider>(context);
}
