import 'package:flutter/material.dart';
import 'package:flutter_login_ui/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  late  DatabaseConnection _databaseConnection;

  Repository(){

    _databaseConnection = DatabaseConnection();
  }
    static  Database? _database;
  Future<Database?> get database async{
    if(_database!=null) {
      return _database;
    }
    _database = await _databaseConnection.setDatabase();
    return _database;
  }
  //Inserting data to table
  insertData(table, data) async{
    var connection = await database;

    return await connection?.insert(table, data);
  }
  //Read data from table
  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }
//read data by id
  readDataById(table, itemId ) async{
    var connection = await database;
    return await connection?.query(table, where: 'id=?',whereArgs: [itemId]);
  }
//update data
  updatedata(table,data) async{
    var connection = await database;
    return await connection?.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }
//delete data
  deletedata(table,itemId)async {
    var connection = await database;
    return await connection?.rawDelete("DELETE FROM $table WHERE id=$itemId");

  }
  //search data
  searchData(table,keyword) async{
    var connection = await database;
    return await connection?.query('select * from $table WHERE name LIKE ?',whereArgs: ['%$keyword%']);
  }



}