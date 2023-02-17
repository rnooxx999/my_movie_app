

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/movie.dart';
import '../../utilities/components.dart';


class SQLiteDB{

  static Database? _db;


  //ميثود تنظر ان كان تم عمل تنصيب للداتابيس فستتجاهل ميثود initialDB، ام اذا لا فيقوم بانشائها
  Future<Database?>? get db async {
    if(_db == null ){
      _db = await initialDB();
    return _db ;
    }else {
      return _db;
    }
  }

  initialDB()async{
    //مسار التطبيق الحالي فقط
    String databasePath = await getDatabasesPath();
    //نضيف للمسار موقع + اسم الداتابيس
    var path = join(databasePath , 'database','movie_database.db');
    //ننشئ الداتابيس عن طريق ايصاله بالملف الذي انشأناه فوق
    Database myDB = await openDatabase(path , onCreate: onCreate , version: 1, onUpgrade: onUpgrade);
print("path :::: $path");
    return myDB;
  }

  //  فانكشن تنشئ الجدول اي يجب ان تبدأ مرة واحدة فقط
   onCreate(Database db ,int version )async{

    // تصنع عدة جداول مرة وحدة بدلا من استخدام await db.execute
    Batch batch = db.batch();

    await db.execute(''' 
    CREATE TABLE $databaseName(
        table_id INTEGER PRIMARY KEY AUTOINCREMENT,
         id INTEGER UNIQUE,
          title TEXT,
              overview TEXT,
                 backdrop_path TEXT,
                 is_watched BOOLEAN DEFAULT 0,
                 vote_average DOUBLE ,
                 vote_count DOUBLE ,
                 release_date TEXT,
                 genre_ids ARRAY NULLABLE,
                    poster_path TEXT )
                        '''
      );
    print("create DATABASE _____++++______+++++____+++");
  }

  onUpgrade(Database db ,int oldVersion, int newVersion, )async{
    await db.execute(''' 
    CREATE TABLE $databaseName(
        table_id INTEGER PRIMARY KEY AUTOINCREMENT ,
         id INTEGER UNIQUE,
          title TEXT,
              overview TEXT,
                 backdrop_path TEXT,
                 is_watched BOOLEAN DEFAULT 0,
                 vote_average DOUBLE ,
                 vote_count DOUBLE ,
                 release_date TEXT,
                   genre_ids ARRAY NULLABLE,
                    poster_path TEXT )
                        '''
    );
    print("ONNNUPDATEE _____++++______+++++____+++");
  }


  //+++++++++++++++++++++++++  sql orders without using model +++++++++++++++++++++++

  // تعمل عمل الselecet اي تجلب البيانات من الداتابيس
  readData(String sql) async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData({required String text}) async{
    Database? mydb = await db;
    //insert ترجعلنا رقم ١ او ٠ اي نجاح او فشل
    int response = await mydb!.rawInsert(
        text
    );
    return response;
  }


  updateData({required int id,required bool isWatched ,Movie? movie}) async{
    Database? mydb = await db;
    //insert ترجعلنا رقم ١ او ٠ اي نجاح او فشل
    int response = await mydb!.rawUpdate(
        '''
      UPDATE $databaseName SET is_watched = $isWatched WHERE id = $id
     '''
    );
    // بسبب ان الsql عملت جدول اضافت فيه بعض البيانات بالفعل قد نريد اضافة فلم غير موجود في بياناتنا فنعمل اضافة اولا ثم تعديل
    if(response == 0 ){
      await insertFromJson(movie!);

        response =await mydb.rawUpdate(
          '''
      UPDATE $databaseName SET is_watched = $isWatched WHERE id = $id
     '''
      );
    }
    return response;
  }

   // delete column
  deleteData(String text) async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(
      text
    );
    return response;
  }



//delete all the database
  databaseDelete()async{
    String databasePath = await getDatabasesPath();
    var path = join(databasePath , 'database','movie_database.db');
    await deleteDatabase(path);
  }



  //+++++++++++++++++++++++++  sql orders with using model ++++++++++++++++++++++++++++


  insertFromJson(Movie movie) async{
    Database? mydb = await db;

    final response = await mydb!.insert(
      databaseName, movie.toJson(),conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return response;
  }


  readFromJson() async{
    Database? mydb = await db;
    List<Map<String,dynamic>> response = await mydb!.query(databaseName);
    List<Movie> move = response.map((e) => Movie.fromJson(e)).toList();
    return move;
  }

  //another try read sql
  // readFromJsonAnotherTry() async{
  //   Database? mydb = await db;
  //   final res = await mydb!.rawQuery("SELECT * FROM watched");
  //   List<Movie> list =
  //   res.isNotEmpty ? res.map((c) => Movie.fromJson(c)).toList() : [];
  //   return list;
  //
  // }

  // updateFromJson(int? id) async{
  //   Movie? movie;
  //   Database? mydb = await db;
  //   final response = await mydb!.update(
  //     "watched", movie!.toJson(),where: "id = $id",
  //   );
  //   return response;
  // }





  // SQLiteDbProvider._();
  // static final SQLiteDbProvider db = SQLiteDbProvider._();
  // static Database database;
  //
  //
  //
  // Future<void> insertDog(Movie movie) async {
  //   final db = await database;
  //   await db.insert(
  //     'dogs',
  //     movie.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // Future<Database> get database async {
  //   if (database != null)
  //     return database;
  //   database = await initDB();
  //   return database;
  // }
  // initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, "ProductDB.db");
  //   return await openDatabase(
  //       path,
  //       version: 1,
  //       onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //         await db.execute(
  //             "CREATE TABLE Product ("
  //                 "id INTEGER PRIMARY KEY,"
  //                 "name TEXT,"
  //                 "description TEXT,"
  //                 "price INTEGER,"
  //                 "image TEXT" ")"
  //         );
  //         await db.execute(
  //             "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') "
  //             "values (?, ?, ?, ?, ?)",
  //         [1, "iPhone", "iPhone is the stylist phone ever", 1000, "iphone.png"]
  //         );
  //         await db.execute(
  //         "INSERT INTO Product ('id', 'name', 'description', 'price', 'image')"
  //         "values (?, ?, ?, ?, ?)",
  //         [2, "Pixel", "Pixel is the most feature phone ever", 800, "pixel.png"]
  //         );
  //         await db.execute(
  //         "INSERT INTO Product ('id', 'name', 'description', 'price', 'image')"
  //         "values (?, ?, ?, ?, ?)",
  //         [3, "Laptop", "Laptop is most productive development tool", 2000, "laptop.png"]
  //         );
  //         await db.execute(
  //         "INSERT INTO Product ('id', 'name', 'description', 'price', 'image')"
  //         "values (?, ?, ?, ?, ?)",
  //         [4, "Tablet", "Laptop is most productive development tool", 1500, "tablet.png"]
  //         );
  //         await db.execute(
  //         "INSERT INTO Product"
  //         "('id', 'name', 'description', 'price', 'image')"
  //         "values (?, ?, ?, ?, ?)",
  //         [5, "Pendrive", "Pendrive is useful storage medium", 100, "pendrive.png"]
  //         );
  //         await db.execute(
  //         "INSERT INTO Product"
  //         "('id', 'name', 'description', 'price', 'image')"
  //         "values (?, ?, ?, ?, ?)",
  //         [6, "Floppy Drive", "Floppy drive is useful rescue storage medium", 20, "floppy.png"]
  //         );
  //         }
  //   );
  // }

}