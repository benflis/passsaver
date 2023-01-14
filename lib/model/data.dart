import 'package:flutter/cupertino.dart';
import 'package:passwordsaver/model/item.dart';

class Data extends ChangeNotifier {
  String? email;
  String? password;
  String? picture;

  void setEmail(email) {
    this.email = email;
    notifyListeners();
  }

  void setPass(password) {
    this.password = password;
    notifyListeners();
  }

  void setPic(pic) {
    this.picture = pic;
    notifyListeners();
  }

  bool visible = false;
  List<ItemEmail> emaillist = [];

  int getCountOriginalList() {
    return emaillist.length;
  }

  List<ItemEmail> filteredList = [];
  int getCountFilteredList() {
    return filteredList.length;
  }

  void addEmail(String email, String password, String picture) {
    emaillist
        .add(ItemEmail(email: email, password: password, picture: picture));
    notifyListeners();
  }

  void receiveData(final data) {
    filteredList = data;
    notifyListeners();
  }

  // void removeData(int index) {
  //   print(emaillist[index].email);

  //   emaillist.removeAt(index);
  //   print(emaillist[index].email);

  //   if (filteredList.length != 0) {
  //     filteredList.removeAt(index);
  //   }
  //   notifyListeners();
  // }

  void addSearch(final data) {
    filteredList = data;
    notifyListeners();
  }

  void emptySearch() {
    if (filteredList.length != 0) {
      filteredList.removeRange(0, filteredList.length);
    }
    notifyListeners();
  }

  void addEmails(List<ItemEmail> list) {
    emaillist = list;
  }

  void changeVisibility() {
    visible = !visible;
    notifyListeners();
  }
}
