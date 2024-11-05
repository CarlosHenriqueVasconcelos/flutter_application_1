class CaloriasModel {
  // Armazena as calorias consumidas por dia do mês (chave = dia, valor = calorias)
  Map<int, double> caloriasPorDia = {};

  // Adiciona calorias ao dia especificado
  void adicionarCalorias(int dia, double calorias) {
    caloriasPorDia[dia] = calorias;
  }

  // Calcula a média de calorias consumidas durante o mês
  double calcularMediaCalorias() {
    if (caloriasPorDia.isEmpty) {
      return 0.0;
    }
    double totalCalorias = caloriasPorDia.values.reduce((a, b) => a + b);
    return totalCalorias / caloriasPorDia.length;
  }

  // Retorna o resumo do mês (calorias consumidas por dia)
  Map<int, double> obterResumoMes() {
    return caloriasPorDia;
  }
}
