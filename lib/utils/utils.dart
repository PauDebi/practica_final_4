import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  final Uri uri = Uri.parse(url);
  if (scan.tipus == 'http') {
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }
  else {
      Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}