import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'package:get/get.dart';

class CadastroPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: authController.emailError.value.isEmpty ? null : authController.emailError.value,
              ),
              onChanged: (value) {
                authController.emailError.value = '';
              },
            )),
            Obx(() => TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                errorText: authController.passwordError.value.isEmpty ? null : authController.passwordError.value,
              ),
              onChanged: (value) {
                authController.passwordError.value = '';
              },
            )),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  authController.emailError.value = 'O e-mail não pode estar vazio.';
                } else if (!_isValidEmail(emailController.text)) {
                  authController.emailError.value = 'Por favor, insira um e-mail válido.';
                }

                if (passwordController.text.isEmpty) {
                  authController.passwordError.value = 'A senha não pode estar vazia.';
                } else if (passwordController.text.length < 6) {
                  authController.passwordError.value = 'A senha deve ter pelo menos 6 caracteres.';
                }

                if (authController.emailError.value.isEmpty && authController.passwordError.value.isEmpty) {
                  await authController.register(
                    emailController.text,
                    passwordController.text,
                  );
                  if (authController.user.value != null) {
                    Get.snackbar('Sucesso', 'Cadastro realizado com sucesso!');
                    Get.offAllNamed('/agenda');
                  } else {
                    Get.snackbar('Erro', 'Erro ao fazer cadastro!');
                  }
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }
}
