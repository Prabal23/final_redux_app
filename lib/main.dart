
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:final_redux/model.dart';
import 'package:final_redux/thunk.dart';
import 'package:final_redux/action.dart';
import 'package:final_redux/reducer.dart';

void main() => runApp(new MyApp());

// THIS IS AN EXTERNAL GLOBAL CODE
final store = new Store<NameState>(reducer,
initialState: new NameState(title: 'this is title', name: []),  middleware: [thunkMiddleware]);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    store.dispatch(nameData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StoreProvider<NameState>(
      store: store,
      child: new MaterialApp(
        home: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController price1 = TextEditingController();

  String item_title = "";
  String item_body = "";
  bool activity = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("API Testing"),
      ),
      body: SingleChildScrollView(
        child: new Center(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    hintText: "Enter Title"
                  ),
                  onChanged: (value) {
                    item_title = value;
                  },
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: price1,
                  decoration: InputDecoration(
                    hintText: "Enter Body"
                  ),
                  onChanged: (value) {
                    item_body= value;
                  },
                ),
                SizedBox(height: 5),
                RaisedButton(
                  onPressed : (){
                    _addingToList(store.state.name);
                    // setState((){
                    //   _addItemlist(item_title, item_body);
                    // });
                    controller1.text = "";
                    price1.text = "";
                  },
                  color: Colors.blue,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Divider(color: Colors.grey),
                StoreConnector<NameState, List>(
                  converter: (store) => store.state.name,
                  builder: (context, items) => Column(children: _someLists(store.state.name)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _addingToList(storeData){
    List<Widget> list1 = [];
    var l1;

    for(var l in storeData){
      l1 = l;
    }
    setState((){
      _addItemlist(l1, item_title, item_body);
    });

    return list1;
  }

  List<Widget> _someLists(storeData) {
    List<Widget> list = [];
    //var index = 0;
    for (var d in storeData) {
      list.add(
        ListTile(
          onLongPress: (){
            setState((){
              d.isSelected = true;
            });
            //_changeItem(d);
            if (d != null) {
              item_title = d.title;
              controller.text = d.title;
              item_body = d.body;
              price.text = d.body;
            }
            
            // return showDialog<String>(
            //   context: context,
            //   barrierDismissible: true,
            //   builder: (BuildContext context){
            //     return Container(
            //       child: SingleChildScrollView(
            //         child: AlertDialog(
            //           title: Text("Details"),
            //           content: Container(
            //             padding: EdgeInsets.only(left: 10, right: 10),
            //             child: new Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 TextField(
            //                   controller: controller,
            //                   decoration: InputDecoration(
            //                     hintText: "Enter Title"
            //                   ),
            //                   onChanged: (value) {
            //                     item_title = value;
            //                   },
            //                 ),
            //                 SizedBox(height: 10,),
            //                 TextField(
            //                   controller: price,
            //                   decoration: InputDecoration(
            //                     hintText: "Enter Body"
            //                   ),
            //                   onChanged: (value) {
            //                     item_body= value;
            //                   },
            //                 ),
            //                 SizedBox(height: 5),
            //                 RaisedButton(
            //                   onPressed : (){
            //                     setState((){
            //                       _editItemlist(d, item_title, item_body);
            //                     });
            //                     Navigator.of(context).pop();
            //                   },
            //                   color: Colors.blue,
            //                   child: Text(
            //                     "Update",
            //                     style: TextStyle(color: Colors.white),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   }
            // );
          },
          //leading: Text('${d.id}'),
          title:d.isSelected == false ? Text(d.title, maxLines: 1, style: TextStyle(fontSize: 15, color: Colors.black),) :
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter Body"
            ),
            onChanged: (value) {
              item_title= value;
            },
          ),
          subtitle: d.isSelected == false ? Text(d.body, maxLines: 2,) :
          TextField(
            controller: price,
            decoration: InputDecoration(
              hintText: "Enter Body"
            ),
            onChanged: (value) {
              item_body= value;
            },
          ),
          dense: true,
          isThreeLine: true,
          trailing: Column(
            children: <Widget>[
              d.isSelected == false ? 
              IconButton(icon: Icon(Icons.delete_forever), onPressed: (){
                setState(() {
                  _deleteItem(d);
                });
              },) :
              IconButton(icon: Icon(Icons.edit), onPressed: (){
                setState(() {
                  _editItemlist(d, item_title, item_body);
                  d.isSelected = false;
                });
              },) 
            ],
          ),
        ),
      );
      //index++;
    }

    return list;
  }

  void _show() {
    store.dispatch(nameData);
  }

  void _changeItem(d){
    store.dispatch(changeItemById(d));
  }

  void _addItemlist(l1, String title_name, String body_name){
    store.dispatch(addItemlist(l1, title_name, body_name));
  }

  void _editItemlist(d, String title_name, String body_name){
    store.dispatch(editItemlist(d, title_name, body_name));
  }

  void _deleteItem(d){
    store.dispatch(deleteItemById(d));
  }
}


