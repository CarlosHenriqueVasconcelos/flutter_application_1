import 'package:flutter/material.dart';
import 'views/agenda_page.dart';

void main() {
  runApp(const MeuAplicativo());// iniciando widget 
}

class MeuAplicativo extends StatelessWidget { // stateles pois nao tem interações dinamicas
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) { // builda a estruturta
    return MaterialApp(
      title: 'Cálculo de Calorias', // titulo do app
      debugShowCheckedModeBanner: false, //banner de depuração
      theme: ThemeData( // definindo tema do aplicativo geral
      
        primarySwatch: Colors.green, // cor principal

        
        appBarTheme: const AppBarTheme( // usando const pois não tera alteração
          color: Colors.green, // Cor do AppBar
          elevation: 0, // Sem sombra
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Cor dos botões 
            foregroundColor: Colors.white, // Cor do texto nos botões
          ),
        ),
        textTheme: const TextTheme(
          
          bodyLarge: TextStyle(color: Colors.black),  // cor corpo do texto
          bodyMedium: TextStyle(color: Colors.black), // cor corpo do texto
          headlineSmall: TextStyle(color: Colors.green), // Títulos (pequenos) em verde
        ),
        // Definindo outras cores que podem ser personalizadas
        scaffoldBackgroundColor: Colors.white, // Fundo branco
      ),
      home: const AgendaPage(), // Página inicial
    );
  }
}
