class Electroniccards{
   int? id;
   String? name;
   String? quantity;
   String? acquisitiondate;

  electroniccardsMap(){
    var mapping= Map<String, dynamic>();
    mapping['id']=id;
    mapping['name']=name;
    mapping['quantity']=quantity;
    mapping['acquisitiondate']=acquisitiondate;


    return mapping;
  }


}