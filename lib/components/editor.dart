
import 'package:flutter/material.dart';

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