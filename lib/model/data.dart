import 'package:flutter/cupertino.dart';
import 'package:passwordsaver/model/item.dart';

class Data extends ChangeNotifier {
  bool visible = false;
  List<ItemEmail> emaillist = [];

  int getCount() {
    return emaillist.length;
  }

  void addEmail(String email, String password, String picture) {
    emaillist
        .add(ItemEmail(email: email, password: password, picture: picture));
    notifyListeners();
  }

  void changeVisibility() {
    visible = !visible;
    notifyListeners();
  }
}
