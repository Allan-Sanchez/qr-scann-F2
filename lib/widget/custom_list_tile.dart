import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class MyListTile extends StatelessWidget {
  final String type;

  const MyListTile({Key key, @required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scanList = scanListProvider.scanList;
    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (_, i) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                  "Eliminando...",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.auto_delete,
                  color: Colors.white,
                )
              ],
            ),
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanListProvider>(context, listen: false)
                .deleteScanProvider(scanList[i].id);
          },
          child: ListTile(
            leading: Icon(
              this.type == 'http' ? Icons.link : Icons.map,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scanList[i].value),
            subtitle: Text('ID: ${scanList[i].id.toString()}',
                style: TextStyle(color: Colors.purple[300])),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              launchURL(context, scanList[i]);
            },
          ),
        );
      },
    );
  }
}
