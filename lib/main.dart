import 'package:flutter/material.dart';
import 'package:practica_final_4/providers/scan_list_provider.dart';
import 'package:practica_final_4/providers/ui_provider.dart';
import 'package:practica_final_4/screens/mapa_screen.dart';
import 'package:practica_final_4/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => UiProvider()),
    ChangeNotifierProvider(create: (_) => ScanListProvider()),
  ],
  child: MyApp()
  ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mapa': (_) => MapaScreen(),
      },
      theme: ThemeData(
        // No es pot emprar colorPrimary des de l'actualització de Flutter
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
