import 'package:flutter/material.dart';
import '../controllers/calorias_controller.dart';

class ResumoMesPage extends StatelessWidget {
  final CaloriasController _caloriasController;

  ResumoMesPage(this._caloriasController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Mês'),
      ),
      body: FutureBuilder(
        future: _caloriasController.obterResumo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final calorias = snapshot.data as List<Map<String, dynamic>>;

          if (calorias.isEmpty) {
            return const Center(child: Text('Nenhuma caloria registrada.'));
          }

          return ListView.builder(
            itemCount: calorias.length,
            itemBuilder: (context, index) {
              final registro = calorias[index];
              return ListTile(
                title: Text('Dia: ${registro['dia']}'),
                subtitle: Text('Calorias: ${registro['calorias']}'),
              );
            },
          );
        },
      ),
    );
  }
}
