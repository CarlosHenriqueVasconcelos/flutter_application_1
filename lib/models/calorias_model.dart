class CaloriasModel {
  Map<int, double> caloriasPorDia = {};

  void adicionarCalorias(int dia, double calorias) {
    caloriasPorDia[dia] = calorias;
  }

  double calcularMediaCalorias() {
    if (caloriasPorDia.isEmpty) {
      return 0.0;
    }
    double totalCalorias = caloriasPorDia.values.reduce((a, b) => a + b);
    return totalCalorias / caloriasPorDia.length;
  }

  Map<int, double> obterResumoMes() {
    return caloriasPorDia;
  }

  // Método para converter o objeto em um mapa para armazenamento no Firestore.
  Map<String, dynamic> toMap() {
    return {
      'caloriasPorDia': caloriasPorDia.map((key, value) => MapEntry(key.toString(), value)),
    };
  }

  // Método para criar um objeto a partir de um mapa (útil para deserialização do Firestore).
  static CaloriasModel fromMap(Map<String, dynamic> map) {
    final caloriasModel = CaloriasModel();
    if (map['caloriasPorDia'] != null) {
      map['caloriasPorDia'].forEach((key, value) {
        caloriasModel.adicionarCalorias(int.parse(key), value);
      });
    }
    return caloriasModel;
  }
}
