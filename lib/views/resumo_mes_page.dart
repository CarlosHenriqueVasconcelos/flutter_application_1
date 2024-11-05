import 'package:flutter/material.dart';
import '../controllers/calorias_controller.dart';

class ResumoMesPage extends StatelessWidget {// sempre criando uma nova instancia
  final CaloriasController caloriasControllerLogic;

  const ResumoMesPage({super.key, required this.caloriasControllerLogic});// requer acesso aos dados por isso o required no controlador

  @override
  Widget build(BuildContext context) {
    final resumo = caloriasControllerLogic.caloriasModel.obterResumoMes();
    final media = caloriasControllerLogic.caloriasModel.calcularMediaCalorias();

    // Ordenando o resumo por dia (chave do mapa)
    final diasOrdenados = resumo.keys.toList()..sort(); // converte map para uma lista e ordena de forma crescente com base nos dias

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Mês'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(// colum para organizar os itens um embaixo do outro
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo das Calorias Consumidas por Dia:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: diasOrdenados.length,
                itemBuilder: (context, index) {
                  final dia = diasOrdenados[index];
                  final calorias = resumo[dia];

                  return ListTile(
                    title: Text('Dia $dia: ${calorias ?? 0} calorias'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),// cria espaço de 20 unidade de distancia entre os elementos
            Text(
              'Média de Calorias no Mês: ${media.toStringAsFixed(2)} calorias/dia',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
