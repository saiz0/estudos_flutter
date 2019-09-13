import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To_do_list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'To_do_list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item {
  String titulo;
  bool status;

  Item(String _titulo, bool _status) {
    this.titulo = _titulo;
    this.status = _status;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _item = new TextEditingController();
  List<Item> lista = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("To_do_list"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: new Column(
                        children: <Widget>[
                          new CheckboxListTile(
                              value: lista[index].status,
                              title: new Text(lista[index].titulo),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool _status) {
                                status(_status, index);
                              },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: new TextField(
          controller: _item,
          decoration: new InputDecoration(hintText: 'Digite sua tarefa'),
          style: TextStyle(fontSize: 30),
          onSubmitted: (value) {
            lista.add(Item(value, false));
            setState(() {});
            _item.clear();
          },
        ),
      ),
    );
  }

  void status(bool val, int index) {
    setState(() {
      lista[index].status = val;
    });
  }

  void deletar(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }
}
