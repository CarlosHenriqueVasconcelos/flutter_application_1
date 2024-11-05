import 'package:flutter/material.dart';
import '../controllers/calorias_controller.dart';
import '../models/calorias_model.dart';
import 'resumo_mes_page.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final CaloriasController _caloriasControllerLogic = CaloriasController(CaloriasModel());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave global para o Formulário
  final TextEditingController _caloriasController = TextEditingController();
  final TextEditingController _diaController = TextEditingController();
  String _feedbackMessage = ''; // Usada para mostrar feedback

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Calorias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Atribuímos a chave ao Formulário
          child: Column(
            children: [
              // Campo para digitar o dia
              TextFormField(
                controller: _diaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite o dia do mês (1-31)',
                ),
              ),
              const SizedBox(height: 10),

              // Campo para digitar as calorias
              TextFormField(
                controller: _caloriasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite as calorias consumidas',
                ),
              ),
              const SizedBox(height: 20),

              // Botão para adicionar calorias
              ElevatedButton(
                onPressed: () {
                  final caloriasInput = _caloriasController.text;
                  final diaInput = _diaController.text;

                  // Chama a validação no controlador
                  final erro = _caloriasControllerLogic.validarEntrada(caloriasInput, diaInput);
                  if (erro.isEmpty) {
                    // Validação bem-sucedida, processa os dados
                    final calorias = double.parse(caloriasInput);
                    final dia = int.parse(diaInput);

                    setState(() {
                      _caloriasControllerLogic.adicionarCalorias(dia, calorias);
                      _feedbackMessage = ''; // Limpa qualquer mensagem anterior
                    });

                    // Exibe a confirmação com o ícone de sucesso
                    _exibirConfirmacao(isSuccess: true);
                  } else {
                    // Exibe o erro de validação
                    setState(() {
                      _feedbackMessage = erro;
                    });
                  }
                },
                child: const Text('Adicionar Calorias ao Dia'),
              ),
              const SizedBox(height: 10),

              // Exibe o feedback caso haja alguma mensagem
              if (_feedbackMessage.isNotEmpty)
                Text(
                  _feedbackMessage,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),

              // Botão para ver o resumo do mês
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumoMesPage(caloriasControllerLogic: _caloriasControllerLogic),
                    ),
                  );
                },
                child: const Text('Ver Resumo do Mês'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para exibir o pop-up com o ícone de sucesso ou erro
  void _exibirConfirmacao({required bool isSuccess}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede o fechamento ao clicar fora
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Calorias Adicionadas!' : 'Erro na Inserção!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Exibe o ícone de validação ou erro com base no sucesso da operação
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess
                    ? 'As calorias foram adicionadas com sucesso!'
                    : 'Por favor, verifique os dados inseridos.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
