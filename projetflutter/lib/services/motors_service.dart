import 'package:flutter_login_ui/models/motor.dart';
import 'package:flutter_login_ui/repositories/repository.dart';

class MotorsServicce{
  late Repository _repository;

  MotorsServicce(){
    _repository = Repository();
  }

  //Create data
  savemotor(Motor motor) async{
    return await _repository.insertData('motor', motor.motorMap());
  }
  //Read data
  readmotor() async{
    return await _repository.readData('motor');
  }
//Read data by id
  readmotorById(id) async{
    return await _repository.readDataById('motor',id);
  }
//update data
  updatemotor(Motor motor)async {
    return await _repository.updatedata('motor',motor.motorMap());
  }
//delete data
  deleteCards(motorId) async{
    return await _repository.deletedata('motor',motorId);

  }
  //seach data
  searchcards(name) async{
    return await _repository.searchData('motor',name);
  }
}