import 'package:flutter_login_ui/models/empreinte.dart';
import 'package:flutter_login_ui/repositories/repository.dart';

class EmpreinteService{

  Repository? _repository;
  EmpreinteService(){
    _repository = Repository();
  }
//create data
  saveEmpreinte(Empreinte empreinte) async{
    return await _repository?.insertData('emprunts', empreinte.empreinteMap());


  }
   readEmpreinte() async{
    return await _repository?.readData('emprunts');

   }

}