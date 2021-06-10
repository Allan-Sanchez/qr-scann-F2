import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final _url = scan.value;

  if (scan.type == 'http') {
    return await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';
  } else {
    Navigator.pushNamed(context, '/mapa',arguments: scan);
  }
}
