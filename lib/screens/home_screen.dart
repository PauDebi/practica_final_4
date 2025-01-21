import 'package:flutter/material.dart';
import 'package:practica_final_4/models/scan_model.dart';
import 'package:practica_final_4/providers/db_provider.dart';
import 'package:practica_final_4/providers/ui_provider.dart';
import 'package:practica_final_4/screens/screens.dart';
import 'package:practica_final_4/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
            onPressed: () {},
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

    DbProvider.dbProvider.database;
    ScanModel scanModel = ScanModel(valor: 'http://www.google.com');
    DbProvider.dbProvider.insertScan(scanModel);

    switch (currentIndex) {
      case 0:
        return MapasScreen();

      case 1:
        return DireccionsScreen();

      default:
        return MapasScreen();
    }
  }
}
