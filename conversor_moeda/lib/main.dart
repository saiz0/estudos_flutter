import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Conversor de Moedas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double de = 0;
  double para = 0;
  double resultado = 0;
  List<String> _moedas = ["Real - BRL", "Dólar - USD"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selecaoMoeda1;
  String _selecaoMoeda2;
  void _incrementCounter() {
    setState(() {});
  }

 calc(double de) {
    setState(() {
           resultado = (de * 4.3);

    });
  }

  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_moedas);
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List moedas) {
    List<DropdownMenuItem<String>> items = List();
    for (String moeda in moedas) {
      items.add(DropdownMenuItem(value: moeda, child: Text(moeda)));
    }
    return items;
  }

  void changedDropDownItem1(String selecaoMoeda1) {
    setState(() {
      _selecaoMoeda1 = selecaoMoeda1;
    });
  }

  void changedDropDownItem2(String selecaoMoeda2) {
    setState(() {
      _selecaoMoeda2 = selecaoMoeda2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Selecione a moeda"),
            DropdownButton(
              value: _selecaoMoeda1,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem1,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Valor:",
                  labelStyle: TextStyle(color: Colors.deepPurple)),
              onChanged: (text) {
               calc(double.parse(text));
              },
            ),
            Text("Selecione a moeda"),
            DropdownButton(
              value: _selecaoMoeda2,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem2,
            ),
            Text(
              'Valor: $resultado!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
