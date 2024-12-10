// lib/services/calorias_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/calorias_model.dart';

class CaloriasService {
  final CaloriasModel _caloriasModel;
  final CollectionReference _caloriasCollection = FirebaseFirestore.instance.collection('calorias');

  CaloriasService(this._caloriasModel);

  String validarEntrada(String caloriasInput, String diaInput) {
    if (diaInput.isEmpty) {
      return 'O dia não pode estar vazio.';
    }
    final dia = int.tryParse(diaInput);
    if (dia == null || dia < 1 || dia > 31) {
      return 'Por favor, insira um dia válido (1-31).';
    }

    if (caloriasInput.isEmpty) {
      return 'As calorias não podem estar vazias.';
    }
    final calorias = double.tryParse(caloriasInput);
    if (calorias == null || calorias < 0) {
      return 'Por favor, insira um valor numérico válido.';
    }

    return ''; // Retorna uma string vazia se não houver erro
  }

  void adicionarCalorias(int dia, double calorias) {
    _caloriasModel.adicionarCalorias(dia, calorias);
  }

  Future<List<Map<String, dynamic>>> obterResumo() async {
    try {
      // Busca os dados do Firestore
      QuerySnapshot snapshot = await _caloriasCollection.get();
      
      // Converte os documentos para uma lista de mapas
      List<Map<String, dynamic>> listaCalorias = snapshot.docs.map((doc) {
        return {
          'dia': doc['dia'], // Certifique-se de que o nome do campo seja igual ao do seu documento
          'calorias': doc['calorias'], // Certifique-se de que o nome do campo seja igual ao do seu documento
        };
      }).toList();
      
      return listaCalorias;
    } catch (e) {
      print("Erro ao obter resumo: $e");
      return [];
    }
  }
}
