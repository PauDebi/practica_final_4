import 'package:flutter/material.dart';
import 'package:practica_final_4/providers/ui_provider.dart';
import 'package:practica_final_4/screens/screens.dart';
import 'package:practica_final_4/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).esborrarScans();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOptGetter;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.carrregarScansPerTipus('geo');
        return MapasScreen();

      case 1:
        scanListProvider.carrregarScansPerTipus('http');
        return DireccionsScreen();

      default:
        return MapasScreen();
    }
  }
}
