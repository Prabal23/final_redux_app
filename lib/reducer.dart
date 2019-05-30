import 'package:final_redux/model.dart';
import 'package:final_redux/action.dart';


NameState reducer(NameState state, dynamic action) {

   if (action is NameAction) {
     
     return NameState(
       name: []
         // ..addAll(state.name)
          ..addAll(action.showAction)
         // ..add(action.showAction[])
          );
      // action.showAction
      
  }

  return state;

}