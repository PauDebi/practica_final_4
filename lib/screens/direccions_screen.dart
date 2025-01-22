import 'package:flutter/material.dart';
import 'package:practica_final_4/widgets/scan_tiles.dart';

class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: "http");
  }
}
