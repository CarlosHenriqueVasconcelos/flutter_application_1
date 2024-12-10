import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../services/calorias_service.dart';

class CaloriasController extends GetxController {
  final CaloriasService _caloriasService;
  Rx<User?> user = Rx<User?>(null);

  CaloriasController(this._caloriasService);

  @override
  void onInit() {
    super.onInit();
    user.value = FirebaseAuth.instance.currentUser;
  }

  String validarEntrada(String caloriasInput, String diaInput) {
    return _caloriasService.validarEntrada(caloriasInput, diaInput);
  }

  void adicionarCalorias(int dia, double calorias) {
    _caloriasService.adicionarCalorias(dia, calorias);
  }

  Future<List<Map<String, dynamic>>> obterResumo() async {
    return _caloriasService.obterResumo();
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      user.value = null; // Define o usuário como nulo após o logout
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }
}
