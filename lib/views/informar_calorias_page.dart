import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatação de datas

class InformarCaloriasPage extends StatefulWidget {
  final DateTime data;

  const InformarCaloriasPage({Key? key, required this.data}) : super(key: key);

  @override
  _InformarCaloriasPageState createState() => _InformarCaloriasPageState();
}

class _InformarCaloriasPageState extends State<InformarCaloriasPage> {
  final TextEditingController _caloriasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informar Calorias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Data selecionada: ${DateFormat('dd/MM/yyyy').format(widget.data)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _caloriasController,
              decoration: const InputDecoration(
                labelText: 'Quantidade de calorias',
                hintText: 'Digite o valor',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final calorias = double.tryParse(_caloriasController.text);
                if (calorias != null) {
                  // Adicione a lógica para salvar as calorias e navegue de volta
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Erro'),
                      content: const Text('Por favor, insira um valor numérico válido.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Salvar Calorias'),
            ),
          ],
        ),
      ),
    );
  }
}
