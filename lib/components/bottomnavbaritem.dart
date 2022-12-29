import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavItem extends StatelessWidget {
  BottomNavItem(
      {required this.pic, required this.selectedIndex, required this.index});

  String pic;
  int selectedIndex;
  int index;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      pic,
      height: 28,
      width: 28,
      color: selectedIndex == index ? Colors.blue : Colors.white,
    );
  }
}
