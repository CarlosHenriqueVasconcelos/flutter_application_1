import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:flutter_application_1/views/agenda_page.dart'; // Importação da página de agenda
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart'; // Importação do GetX

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MeuAplicativo()); // Iniciando widget
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cálculo de Calorias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.green),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/', // Rota inicial
      getPages: [
        GetPage(name: '/', page: () => LoginPage()), // Rota para a página de login
        GetPage(name: '/agenda', page: () => AgendaPage()), // Rota para a página de agenda
      ],
    );
  }
}
