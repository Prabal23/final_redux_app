import 'package:final_redux/model.dart';
import 'package:final_redux/action.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'dart:convert'; // to convert Response object to Map object
import 'package:final_redux/post.dart';
import 'package:http/http.dart' as http;


ThunkAction<NameState> nameData = (Store<NameState> store) async {

  String url = "https://jsonplaceholder.typicode.com/posts";
   var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

  List collection = json.decode(response.body);

  var _messages = collection.map((json) => Message.fromJson(json)).toList();
  print(store.state.title);
  store.dispatch(
    new NameAction(
      _messages   
    )
  );
};

ThunkAction<NameState> changeItemById(d) => (Store<NameState> store) async{
  for(var data in store.state.name){
    if(data.id == d.id){
      d.id = 50;
      // data.isSelected = !data.isSelected;
    }
  }
  store.dispatch(
    new NameAction(
      store.state.name
    )
  );
};

ThunkAction<NameState> addItemlist(l1, String title1, String body1) => (Store<NameState> store) async{
  int _id = l1.id;
  _id++;
  store.state.name.add(NameState(id: _id, title: title1, body: body1, isSelected: false));
  
  store.dispatch(
    new NameAction(
      store.state.name
    )
  );
};

ThunkAction<NameState> editItemlist(d, String title, String body) => (Store<NameState> store) async{
  for(var data in store.state.name){
    if(data.id == d.id){
      d.title = title;
      d.body = body;
    }
  }
  
  store.dispatch(
    new NameAction(
      store.state.name
    )
  );
};

ThunkAction<NameState> deleteItemById(d) => (Store<NameState> store) async{
  for(var data in store.state.name){
    if(data.id == d.id){
      store.state.name.remove(data);
    }
  }
  
  store.dispatch(
    new NameAction(
      store.state.name
    )
  );
};