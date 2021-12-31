import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseConnection{
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path =join(directory.path,'db_projet_sqflite');
    var database = await openDatabase(path, version: 5,onCreate: _onCreatingDatabase);
    return database;
  }
  
  _onCreatingDatabase(Database database, int version)async{
    await database.execute('''DROP TABLE IF EXISTS motor ''');
    await database.execute('''CREATE TABLE IF NOT EXISTS electroniccards(id INTEGER PRIMARY KEY, name TEXT,quantity TEXT,acquisitiondate TEXT)''');
   await database.execute('''CREATE TABLE  IF NOT EXISTS motor(idmotor INTEGER PRIMARY KEY AUTOINCREMENT, namemotor TEXT,quantitymotor TEXT,acquisitiondatemotor TEXT)''');
   await database.execute('''CREATE TABLE  IF NOT EXISTS battery(id INTEGER PRIMARY KEY AUTOINCREMENT, namebattery TEXT,quantitybattery TEXT,acquisitiondatebattery TEXT)''');
    await database.execute('''CREATE TABLE  IF NOT EXISTS emprunts(id INTEGER PRIMARY KEY AUTOINCREMENT, namecomposant TEXT,quantitycomposant TEXT,namemembre TEXT,prenommembre TEXT,cin TEXT,numtel TEXT)''');

  }


}