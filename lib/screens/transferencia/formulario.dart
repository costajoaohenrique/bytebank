import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _campoNumeroContaController =
  TextEditingController();
  final TextEditingController _campoValorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando Transferencia"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              editingController: _campoNumeroContaController,
              rotulo: "Numero da Conta",
              dica: "0000",
            ),
            Editor(
              editingController: _campoValorController,
              rotulo: "Valor",
              dica: "0.00",
              icone: Icons.attach_money,
            ),
            RaisedButton(
              onPressed: () => _criar_transferencia(context),
              child: Text("Confirmar"),
            )
          ],
        ),
      ),
    );
  }

  _criar_transferencia(context) {
    debugPrint("Clicou no confirmar");
    int numeroConta = int.tryParse(_campoNumeroContaController.text);
    double valor = double.tryParse(_campoValorController.text);
    Transferencia transferenciaCriada = Transferencia(valor, numeroConta);
    debugPrint("$transferenciaCriada");
    Navigator.pop(context, transferenciaCriada);
  }
}