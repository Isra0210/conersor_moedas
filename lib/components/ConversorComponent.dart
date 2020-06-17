import 'package:flutter/material.dart';

class ConversorComponent extends StatefulWidget {
  final double _dolar;
  final double _euro;

  ConversorComponent(this._dolar, this._euro);

  @override
  _ConversorComponentState createState() => _ConversorComponentState();
}

class _ConversorComponentState extends State<ConversorComponent> {
  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();

  void _clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  void _realChanger(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    _dolarController.text = (real / widget._dolar).toStringAsFixed(2);
    _euroController.text = (real / widget._euro).toStringAsFixed(2);
  }

  void _dolarChanger(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    _realController.text = (dolar * this.widget._dolar).toStringAsFixed(2);
    _euroController.text =
        (dolar * this.widget._dolar / widget._euro).toStringAsFixed(2);
  }

  void _euroChanger(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    _realController.text = (euro * this.widget._euro).toStringAsFixed(2);
    _dolarController.text =
        (euro * this.widget._euro / widget._dolar).toStringAsFixed(2);
  }

  Widget _textField(String moeda, String cifrao, TextEditingController contol,
      Function fun, Icon icon) {
    return TextField(
      controller: contol,
      decoration: InputDecoration(
        labelText: moeda,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        prefixIcon: icon,
      ),
      keyboardType: TextInputType.number,
      onChanged: fun,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50.0),
        height: MediaQuery.of(context).size.height - 50,
        child: Column(
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              size: 150.0,
              color: Colors.amber,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  _textField(
                      "Reais",
                      "R\$",
                      _realController,
                      _realChanger,
                      Icon(
                        Icons.money_off,
                        color: Colors.amber,
                      )),
                  Divider(),
                  _textField(
                      "Dólar",
                      "US\$",
                      _dolarController,
                      _dolarChanger,
                      Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                      )),
                  Divider(),
                  _textField(
                      "Euro",
                      "€",
                      _euroController,
                      _euroChanger,
                      Icon(
                        Icons.euro_symbol,
                        color: Colors.amber,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
