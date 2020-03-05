import 'package:flutter/material.dart';

class AlcoolOuGasolina extends StatefulWidget {
  @override
  _AlcoolOuGasolinaState createState() => _AlcoolOuGasolinaState();
}

class _AlcoolOuGasolinaState extends State<AlcoolOuGasolina> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = "";
  FocusNode _focusNodeAlcool = FocusNode();
  FocusNode _focusNodeGasolina = FocusNode();
  Color _validation = Colors.black;

  void _calcular() {
    Map valores = _validarCampos();

    if (valores != null) {
      _validation = Colors.black;
      if ((valores["alcool"] / valores["gasolina"]) >= 0.7) {
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina.";
        });
      } else {
        setState(() {
          _textoResultado = "Melhor abastecer com álcool.";
        });
      }
      _limparCampos();
    }
  }

  Map _validarCampos() {
    Map<String, double> valores;
    if (_controllerAlcool.text.isEmpty || _controllerGasolina.text.isEmpty) {
      setState(() {
        _textoResultado = "Por favor preencha todos os campos.";
        _validation = Colors.red;
      });
      return valores;
    }

    if (_controllerAlcool.text.contains(",")) {
      _controllerAlcool.text = _controllerAlcool.text.replaceFirst(",", ".");
    }

    if (_controllerGasolina.text.contains(",")) {
      _controllerGasolina.text =
          _controllerGasolina.text.replaceFirst(",", ".");
    }

    double valorAlcool = double.tryParse(_controllerAlcool.text);
    double valorGasolina = double.tryParse(_controllerGasolina.text);

    if (valorAlcool == null || valorGasolina == null) {
      setState(() {
        _textoResultado = "Valor(es) inválido(s).";
        _validation = Colors.red;
      });
      return valores;
    }

    if (valorAlcool < 0 || valorGasolina < 0) {
      setState(() {
        _textoResultado = "Por favor digite valores maiores que 0.";
        _validation = Colors.red;
      });
      return valores;
    }
    valores = {"alcool": valorAlcool, "gasolina": valorGasolina};

    return valores;
  }

  void _limparCampos() {
    _controllerAlcool.text = "";
    _controllerGasolina.text = "";
    _focusNodeAlcool.unfocus();
    _focusNodeGasolina.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina"),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("assets/images/logo.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para abastecimento do seu carro.",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              TextField(
                focusNode: _focusNodeAlcool,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço do Álcool",
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerAlcool,
              ),
              TextField(
                focusNode: _focusNodeGasolina,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço da Gasolina",
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerGasolina,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: _calcular,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  _textoResultado,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _validation,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
