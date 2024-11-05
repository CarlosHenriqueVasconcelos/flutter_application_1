import '../models/calorias_model.dart';

class CaloriasController {
  final CaloriasModel caloriasModel;

  CaloriasController(this.caloriasModel);

  // Validação da entrada (calorias e dia)
  String validarEntrada(String caloriasInput, String diaInput) {
    if (caloriasInput.isEmpty || diaInput.isEmpty) {
      return 'Por favor, preencha todos os campos.';
    }
    final calorias = double.tryParse(caloriasInput);
    final dia = int.tryParse(diaInput);

    if (calorias == null || calorias <= 0) {
      return 'Digite um valor válido para calorias.';
    }

    if (dia == null || dia < 1 || dia > 31) {
      return 'Digite um dia válido entre 1 e 31.';
    }

    return ''; // Nenhum erro
  }

  // Adiciona calorias ao modelo
  void adicionarCalorias(int dia, double calorias) {
    caloriasModel.adicionarCalorias(dia, calorias);
  }

  // Retorna o resumo do mês
  Map<int, double> obterResumoMes() {
    return caloriasModel.obterResumoMes();
  }
}
