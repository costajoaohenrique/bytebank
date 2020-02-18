import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        ),
      ),
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

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

class Editor extends StatelessWidget {
  final TextEditingController editingController;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.editingController, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: editingController,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transferencia"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            })).then((tranferenciaRecebida) {
              Future.delayed(
                Duration(seconds: 5),
                () {
                  debugPrint("Chegou no then future");
                  debugPrint("$tranferenciaRecebida");
                  if (tranferenciaRecebida != null) {
                    setState(() {
                      widget._transferencias.add(tranferenciaRecebida);
                    });
                  }
                },
              );
            });
          },
        ),
        body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          },
        ));
    ;
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.attach_money),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
