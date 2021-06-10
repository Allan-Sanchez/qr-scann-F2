import 'package:flutter/material.dart';
import 'package:qr_scanner/widget/custom_list_tile.dart';

class UrlPage extends StatelessWidget {
  const UrlPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyListTile(type: 'http');
  }
}
