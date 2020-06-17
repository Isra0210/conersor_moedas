import 'package:conversor_moedas/components/ConversorComponent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConversorScreen extends StatefulWidget {
  @override
  _ConversorScreenState createState() => _ConversorScreenState();
}

class _ConversorScreenState extends State<ConversorScreen> {
  final _request =
      "https://api.hgbrasil.com/finance?format=json-cors&key=b988b7e2";

  Future<Map> _getData() async {
    final _response = await http.get(_request);
    return json.decode(_response.body);
  }

  double _dolar;
  double _euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Conversor de Moeda',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.amber,
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        child: FutureBuilder<Map>(
            future: _getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Carregando dados...',
                        style: TextStyle(color: Colors.amber),
                      ),
                      SizedBox(height: 30.0),
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ],
                  );
                  break;
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar dados :(',
                        style: TextStyle(color: Colors.amber),
                      ),
                    );
                  } else {
                    _dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    _euro =
                        snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return ConversorComponent(_dolar, _euro);
                  }
              }
            }),
      ),
    );
  }
}
