import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/calorias_model.dart';
import 'package:flutter_application_1/services/calorias_service.dart';
import '../controllers/calorias_controller.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final CaloriasController _caloriasController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _caloriasControllerInput = TextEditingController();
  final TextEditingController _diaControllerInput = TextEditingController();
  String _feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    final caloriasModel = CaloriasModel();
    final caloriasService = CaloriasService(caloriasModel);
    _caloriasController = CaloriasController(caloriasService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Calorias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _caloriasController.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para digitar o dia
              TextFormField(
                controller: _diaControllerInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite o dia do mês (1-31)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O dia não pode estar vazio.';
                  }
                  final dia = int.tryParse(value);
                  if (dia == null || dia < 1 || dia > 31) {
                    return 'Por favor, insira um dia válido (1-31).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo para digitar as calorias
              TextFormField(
                controller: _caloriasControllerInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite as calorias consumidas',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'As calorias não podem estar vazias.';
                  }
                  final calorias = double.tryParse(value);
                  if (calorias == null || calorias < 0) {
                    return 'Por favor, insira um valor numérico válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Botão para adicionar calorias
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final caloriasInput = _caloriasControllerInput.text;
                    final diaInput = _diaControllerInput.text;

                    final erro = _caloriasController.validarEntrada(caloriasInput, diaInput);
                    if (erro.isEmpty) {
                      final calorias = double.parse(caloriasInput);
                      final dia = int.parse(diaInput);

                      _caloriasController.adicionarCalorias(dia, calorias);
                      setState(() {
                        _feedbackMessage = 'Calorias adicionadas com sucesso!';
                      });
                    } else {
                      setState(() {
                        _feedbackMessage = erro;
                      });
                    }
                  }
                },
                child: const Text('Adicionar Calorias ao Dia'),
              ),
              const SizedBox(height: 10),

              // Exibe o feedback de erro ou sucesso
              if (_feedbackMessage.isNotEmpty)
                Text(
                  _feedbackMessage,
                  style: TextStyle(color: _feedbackMessage.contains('sucesso') ? Colors.green : Colors.red),
                ),
              const SizedBox(height: 20),

              // Botão para ver o resumo do mês
              ElevatedButton(
                onPressed: () {
                  if (_caloriasController.user.value != null) {
                    Navigator.pushNamed(context, '/resumo');
                  } else {
                    // Redireciona para a tela de login se o usuário não estiver autenticado
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: const Text('Ver Resumo do Mês'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
