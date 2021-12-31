import 'package:flutter_login_ui/models/electroniccards.dart';
import 'package:flutter_login_ui/repositories/repository.dart';

class ElectroniccardsService{
  late Repository _repository;

  ElectroniccardsService(){
    _repository = Repository();
  }

  //Create data
  saveCards(Electroniccards electroniccards) async{
   return await _repository.insertData('electroniccards', electroniccards.electroniccardsMap());
  }
  //Read data
  readCards() async{
   return await _repository.readData('electroniccards');
  }
//Read data by id
  readCardsById(electroniccardsid) async{
    return await _repository.readDataById('electroniccards',electroniccardsid);
  }
//update data
  updateCards(Electroniccards electroniccards)async {
    return await _repository.updatedata('electroniccards',electroniccards.electroniccardsMap());
  }
//delete data
  deleteCards(electroniccardId) async{
    return await _repository.deletedata('electroniccards',electroniccardId);

  }
  //seach data
searchcards(name) async{
    return await _repository.searchData('electroniccards',name);
}
}