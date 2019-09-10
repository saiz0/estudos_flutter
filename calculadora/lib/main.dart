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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
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
                style: TextStyle(
                  fontSize: 40),
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
                Colors.green,
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
                Colors.green,
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
                Colors.green,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botao('', Colors.lightGreenAccent),
              botao('.', Colors.lightGreenAccent),
              botao('0', Colors.lightGreenAccent),
              botao('+', Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              limpar('AC', Colors.green),
              apagar(Colors.green),
              operacao('=', Colors.green),
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
          });
        },
        color: cor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }
}
