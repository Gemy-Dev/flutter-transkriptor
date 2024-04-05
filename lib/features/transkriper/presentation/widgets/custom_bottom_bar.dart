import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key, required this.index, required this.onSelect,
  });
final int index;
final Function(int) onSelect;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.bg,unselectedItemColor: Colors.grey,
      fixedColor: Theme.of(context).primaryColor,
    unselectedLabelStyle:const TextStyle(color: Colors.grey),
    showUnselectedLabels: true,
      currentIndex:index,
      onTap: onSelect,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.mic),label: 'Records'),
      BottomNavigationBarItem(icon: Icon(Icons.text_snippet),label: 'Transkripts'),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings')
      ,]);
  }
}

