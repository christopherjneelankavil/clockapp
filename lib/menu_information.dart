import 'package:clockapp/enums.dart';
import 'package:flutter/foundation.dart';

class MenuInformation extends ChangeNotifier {
  MenuType currentMenu;
  String title;
  String imgSrc;

  MenuInformation(this.currentMenu, {required this.title, required this.imgSrc});

  void updateMenu(MenuType newMenu, String newTitle, String newImage) {
    currentMenu = newMenu;
    title = newTitle;
    imgSrc = newImage;
    notifyListeners();
  }
}