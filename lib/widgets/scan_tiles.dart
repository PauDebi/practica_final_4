import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica_final_4/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/scan_model.dart';
import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final String tipus;

  const ScanTiles({Key? key, required this.tipus}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => GestureDetector(
        onLongPress: () {
          _showEditDialog(context, scans[i]);
        },
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ),
          child: ListTile(
            leading: Icon(
              tipus == 'http' ? Icons.home_outlined : Icons.map_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scans[i].title!),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () {
              if (tipus == 'http') {
                launchURL(context, scans[i]);
              } else {
                Navigator.pushNamed(context, 'mapa', arguments: scans[i]);
              }
            },
          ),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanListProvider>(context, listen: false).esborrarScanPerId(scans[i].id!);
          },
        ),
      ),
    );
  }
  void _showEditDialog(BuildContext context, ScanModel scan) {
    final TextEditingController controller = TextEditingController(text: scan.title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Display Name'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter new display name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  scan.title = controller.text;
                  Provider.of<ScanListProvider>(context, listen: false).addTitle(scan);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
