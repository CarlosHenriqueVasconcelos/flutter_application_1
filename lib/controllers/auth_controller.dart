import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rx<User?>(null);
  var emailError = ''.obs;
  var passwordError = ''.obs;

  Future<void> login(String email, String password) async {
    emailError.value = '';
    passwordError.value = '';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> register(String email, String password) async {
    emailError.value = '';
    passwordError.value = '';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      user.value = null; // Limpa a variável `user` após logout
    } catch (e) {
      print("Erro ao fazer logout: $e");
      // Você pode adicionar mais lógica de tratamento de erro se necessário
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        emailError.value = 'O endereço de e-mail está mal formatado.';
        break;
      case 'user-not-found':
        emailError.value = 'Usuário não encontrado.';
        break;
      case 'wrong-password':
        passwordError.value = 'Senha incorreta.';
        break;
      case 'weak-password':
        passwordError.value = 'A senha deve ter pelo menos 6 caracteres.';
        break;
      case 'email-already-in-use':
        emailError.value = 'Este e-mail já está em uso.';
        break;
      default:
        emailError.value = 'Erro desconhecido: ${e.message}';
        passwordError.value = 'Erro desconhecido: ${e.message}';
    }
  }
}
