import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NextAnimProvider extends ChangeNotifier {
  bool _nextAnim = false;

  bool get nextAnim => this._nextAnim;

  set nextAnim(bool next) {
    this._nextAnim = next;
    notifyListeners();
  }

  static NextAnimProvider of(BuildContext context) =>
      Provider.of<NextAnimProvider>(context);
}
