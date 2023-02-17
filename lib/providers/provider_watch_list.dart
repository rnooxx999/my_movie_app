


import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/database/sql_database.dart';
import '../model/movie.dart';

class ProviderSqlMovie extends ChangeNotifier {
  List watchedList = [];
  bool isWhatched = false;
  bool isThereNetworkOrNot = true ;
  SQLiteDB sqLiteDB = SQLiteDB();


  Future<List<Map>> readAllDataFromWatchList() async {
    List<Map> responce = await sqLiteDB.readData("SELECT * FROM watched WHERE is_watched = true ORDER BY release_date DESC");
    List<Map> res = await sqLiteDB.readData("SELECT * FROM watched WHERE (is_watched = true AND id = 995133)");
    if(res.isNotEmpty){
      print("true");}
    else {print("false");}
    return responce;

  }



  Future<List<Movie>> readDataForRepoLocal() async {
    List<Movie> list = [];
    var resp = await sqLiteDB.readFromJson();
    return resp;
  }



   flagListCheckOrNot() async {
    List lisMovie = [];
    List<Map> response = await sqLiteDB.readData("SELECT * FROM 'watched'");
   // List listy = lisMovie.add(response.map((e) => e));
    List<Map> listy = response.map((e) => e).toList();
    var op =listy.asMap().values.map((e) => e).toList();
    for(var value in op ){
      var id = value['id'];
      var isWatched = value['is_watched'];
      if(isWatched == 1 ||isWatched == true ){
        if( !watchedList.contains(id)){
        watchedList.add(id);
       // notifyListeners();
        }
      }
    }
   // op is Map<String,dynamic>
    print("isWatchedisWatchedisWatched $watchedList");
    //return lisMovie;
  }



  insertDataToSqlFromApi( json)async{
     var one = sqLiteDB.insertFromJson(
         json
     );

    var responceJustForCheck = await sqLiteDB.readData("SELECT * FROM watched ");
  }

   // insertToData({required int index, int? movieId, String? title,
   //  String?date, String?posterPath, String?overview}) async {
   //   print("jjknlnl");
   //   //if()
   //   if (await isItAddedOrNot(movieId!) == false) {
   //     int response = await sqLiteDB.insertData(
   //         text: '''
   //     INSERT INTO watched( movie_id , title , overview , release_date , poster_path )
   //     VALUES( $movieId ,'$title', '$overview' , '$date' ,'$posterPath' )
   //            '''
   //     );
   //   }
   //     print("movieId $movieId ");
   //     print("isItAddedOrNot! :  ${isItAddedOrNot(movieId!)} ");
   //     // if(!isItAddedOrNot(movieId)) {
   //     // List<Map> responce = await sqLiteDB.readData("SELECT * FROM watched WHERE movie_id = $movieId");
   //     // watchedList.add(responce);
   //     // print(responce);
   //     // }
   //     // else return;
   //     //watchedList.addAll(response);
   //     // var read = await sqLiteDB.readData("SELECT * FROM 'watched'");
   //     // print("read watching: :::: :: $read");
   //
   //     // var read = await sqLiteDB.deleteData(
   //     //   '''
   //     //    DELETE FROM watched WHERE id > 0
   //     //   '''
   //     //
   //     // );
   //     // print("read deleteData: :::: :: $read");
   //     // if(read > 0 ){
   //     //   print("removeWhere");
   //     // }
   //
   //     //  List<Map> newValue = read.map((e) => e['title']);
   //     //   //newValue.map((e) => e)
   //     //   for(int i = 0 ; i > newValue.length ;i++ ){
   //     //     if("" == i ){
   //     //       print("YYYYEESS $i ");
   //     //     }
   //     //     print("newValu $i ");
   //     //   }
   //     // addToWatch.sink.add(read);
   //
   //
   //     // provider.watchedList.removeWhere((element) => element['id'] == provider.watchedList[index]['id']);
   //     // print("watchedList.removeWhere((element)");
   //     // setState(() {
   //     // });
   //
   //
   // }
  // Future<List> readForBool()async{
  //   var read = await readAllData();
  //   var watchedListMap = read.map((e) => e ).toList();
  //   var moveAsMap = watchedListMap.asMap();
  //   List listValuesId = [];
  //   for(var val in moveAsMap.values){
  //     listValuesId.add(val['movie_id']);
  //   }
  //
  //   return listValuesId;
  //
  // }


  //
  // Future<bool> isItAddedOrNot(int movieId)async{
  //   List list =await readForBool() ;
  //
  //
  //   //List toLList = watchedList.map((e) => e.(r) =>r[''] ).toList();
  //   //gg.map((e) => e);
  //   print("contain");
  //
  //   if(list.contains(movieId)){
  //     print(movieId);
  //     isWhatched = true;
  //    return true ;
  //   }
  //   print("not contait");
  //   notifyListeners();
  //
  //   return false;
  //
  // }




}