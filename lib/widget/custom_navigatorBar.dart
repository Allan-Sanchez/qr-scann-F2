import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

class MyNavigatorBar extends StatelessWidget {
  const MyNavigatorBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changePage = Provider.of<UIProvider>(context);
    final currentPage = changePage.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) {
        changePage.selectedMenuOpt = i;
      },
      currentIndex: currentPage,
      elevation: 0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'history'),
      ],
    );
  }
}
