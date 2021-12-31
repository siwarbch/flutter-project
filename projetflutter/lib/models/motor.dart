class Motor{

  int? idmotor ;
  String? namemotor;
  String? quantitymotor;
  String? acquisitiondatemotor;

  motorMap(){
    var mapping= Map<String, dynamic>();
    mapping['idmotor']=idmotor;
    mapping['namemotor']=namemotor;
    mapping['quantitymotor']=quantitymotor;
    mapping['acquisitiondatemotor']=acquisitiondatemotor;


    return mapping;
  }

}