import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qr_scanner/providers/db_provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

import 'package:qr_scanner/screens/mapas_page.dart';
import 'package:qr_scanner/screens/url_page.dart';
import 'package:qr_scanner/widget/custom_floatingButton.dart';
import 'package:qr_scanner/widget/custom_navigatorBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.deleteAllProvider();
              })
        ],
      ),
      body: _BodyPages(),
      bottomNavigationBar: MyNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}

class _BodyPages extends StatelessWidget {
  const _BodyPages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentPage = uiProvider.selectedMenuOpt;
    //usar el scan list provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (currentPage) {
      case 0:
        scanListProvider.getScansForTypeProvider('geo');
        return MapasPage();
        break;
      case 1:
        scanListProvider.getScansForTypeProvider('http');
        return UrlPage();
        break;
      default:
        return MapasPage();
    }
  }
}
