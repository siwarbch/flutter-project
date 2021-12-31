class Battery{
  int? id;
  String? namebattery;
  String? quantitybattery;
  String? acquisitiondatebattery;

  batteryMap(){
    var mapping= Map<String, dynamic>();
    mapping['id']=id;
    mapping['namebattery']=namebattery;
    mapping['quantitybattery']=quantitybattery;
    mapping['acquisitiondatebattery']=acquisitiondatebattery;


    return mapping;
  }


}