class Empreinte{
  int? id;
  String? namemembre;
  String? prenommembre;
  String? cin;
  String? numtel;
  String? namecomposant;
  String? quantitycomposant;

  empreinteMap(){
    var mapping= Map<String, dynamic>();
    mapping['id']=id;
    mapping['namemembre']=namemembre;
    mapping['prenommembre']=prenommembre;
    mapping['cin']=cin;
    mapping['numtel']=numtel;
    mapping['namecomposant']=namecomposant;
    mapping['quantitycomposant']=quantitycomposant;
    return mapping;

  }


}