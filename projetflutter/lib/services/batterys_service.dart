import 'package:flutter_login_ui/models/battery.dart';
import 'package:flutter_login_ui/repositories/repository.dart';

class BatteryService{
  late Repository _repository;

  BatteryService(){
    _repository = Repository();
  }

  //Create data
  saveCards(Battery battery) async{
    return await _repository.insertData('battery', battery.batteryMap());
  }
  //Read data
  readCards() async{
    return await _repository.readData('battery');
  }
//Read data by id
  readCardsById(batteryId) async{
    return await _repository.readDataById('battery',batteryId);
  }
//update data
  updateCards(Battery battery)async {battery.batteryMap();
  }
//delete data
  deleteCards(batteryId) async{
    return await _repository.deletedata('battery',batteryId);

  }
  //seach data
  searchcards(name) async{
    return await _repository.searchData('battery',name);
  }
}