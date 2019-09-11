import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

final input = TextEditingController();
final List<String> listHistorico = <String>[];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
// user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Historico"),
          content: Container(
            width: double.maxFinite,
            height: 300.0,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: listHistorico.map((data) => Text(data)).toList(),
            ),
          ),

          actions: <Widget>[
           new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 30,
                    )),
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.right,
                controller: input,
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              )),
          SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botao(
                '7',
                Colors.lightGreenAccent,
              ),
              botao(
                '8',
                Colors.lightGreenAccent,
              ),
              botao(
                '9',
                Colors.lightGreenAccent,
              ),
              botao(
                '/',
                Colors.lightGreen,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botao('4', Colors.lightGreenAccent),
              botao('5', Colors.lightGreenAccent),
              botao('6', Colors.lightGreenAccent),
              botao(
                '*',
                Colors.lightGreen,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botao('1', Colors.lightGreenAccent),
              botao('2', Colors.lightGreenAccent),
              botao('3', Colors.lightGreenAccent),
              botao(
                '-',
                Colors.lightGreen,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botao('', Colors.lightGreenAccent),
              botao('.', Colors.lightGreenAccent),
              botao('0', Colors.lightGreenAccent),
              botao('+', Colors.lightGreen),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              historico(Colors.lightGreen),
              limpar('AC', Colors.lightGreen),
              apagar(Colors.lightGreen),
              operacao('=', Colors.lightGreen),
            ],
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Widget botao(String texto, Color cor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
          child: Text(texto, style: TextStyle(fontSize: 28.0)),
          onPressed: () {
            setState(() {
              input.text = input.text + texto;
            });
          },
          color: cor,
          padding: EdgeInsets.all(18.0),
          splashColor: Colors.white),
    );
  }

  Widget apagar(Color cor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.keyboard_backspace, size: 35, color: Colors.blueGrey),
        onPressed: () {
          input.text = (input.text.length > 0)
              ? (input.text.substring(0, input.text.length - 1))
              : "";
        },
        color: cor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget historico(Color cor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.history, size: 35, color: Colors.blueGrey),
        onPressed: () {
          _showDialog();
        },
        color: cor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget limpar(String texto, Color cor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          texto,
          style: TextStyle(fontSize: 28.0),
        ),
        onPressed: () {
          setState(() {
            input.text = "";
          });
        },
        color: cor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget operacao(String texto, Color cor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          texto,
          style: TextStyle(fontSize: 28.0),
        ),
        onPressed: () {
          setState(() {
            Parser p = new Parser();
            Expression exp = p.parse(input.text);
            ContextModel cm = new ContextModel();
            input.text = exp.evaluate(EvaluationType.REAL, cm).toString();
            listHistorico.add(exp.toString()+" = " +exp.evaluate(EvaluationType.REAL, cm).toString());

          });
        },
        color: cor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }
}
