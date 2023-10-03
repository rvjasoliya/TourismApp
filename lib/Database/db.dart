import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../View/home_page.dart';

class MyDb {
  late Database db;
  static const _databaseVersion = 1;
  static const defaultData = 'defaultData';
  static const hotel = 'hotel';
  static const place = 'place';
  static const description = 'description';
  static const id = 'cid';
  static const catogery = 'catogery';
  static const name = 'name';
  static const location = 'location';
  static const image = 'image';
  static const price = 'price';
  static const rate = 'rate';
  MyDb._privateConstructor();
  static final MyDb instance = MyDb._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'place.db');
    print(path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _oncreate,
    );
  }
  // Future open() async {
  // var databasesPath = await getDatabasesPath();
  // String path = join(databasesPath, 'place.db');
  // print("Place : $path");

  Future _oncreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('''
                    CREATE TABLE IF NOT EXISTS $place(
                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                          $id INTEGER,
                          $catogery varchar not null,
                          $name varchar not null,
                          $location varchar not null,
                          $description varchar,
                          $image varchar not null
                          );
                      //create more table here
                  ''');
    await db.execute('''
                    CREATE TABLE IF NOT EXISTS $defaultData(
                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                          $id INTEGER,
                          $catogery varchar not null,
                          $name varchar not null,
                          $location varchar not null,
                          $image varchar not null
                          );
                      //create more table here
                  ''');
    await db.execute('''
                    CREATE TABLE IF NOT EXISTS $hotel(
                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                          $image varchar not null,
                          $name varchar not null,
                          $location varchar not null,
                          $price varchar not null,
                          $rate varchar not null
                          );
                      //create more table here
                  ''');

    print("Table Created");
  }

  //
  Future<void> defaultInsertData(String id1, String catogery1, String name1,
      String location1, String image1) async {
    Database? db = await instance.database;
    String defaultValue =
        '''REPLACE INTO $defaultData ("$id", "$catogery", "$name", "$location", "$image") VALUES ("$id1","$catogery1","$name1","$location1","$image1")''';
    var defaultResult = await db!.rawInsert(defaultValue);
  }

  Future<void> placeDataInsert(
      String id1,
      String PlaceImage,
      String PlaceCatogery,
      String PlaceName,
      String PlaceLocation,
      String PlaceDesc) async {
    Database? db = await instance.database;
    String placeValue =
        '''INSERT OR REPLACE INTO $place ("$id", "$catogery", "$name", "$location","$description", "$image") VALUES ("$id1", "$PlaceCatogery","$PlaceName","$PlaceLocation","$PlaceDesc","$PlaceImage")''';

    var placeResult = await db!.rawInsert(placeValue);
  }

  //
  Future<void> hotelDataInsert(String HotelImage, String HotelName,
      String HotelLocation, String HotelPrice, String HotelRate) async {
    Database? db = await instance.database;
    String hotelValue =
        '''INSERT OR REPLACE INTO $hotel ("$image", "$name", "$location","$price", "$rate") VALUES ("$HotelImage","$HotelName","$HotelLocation","$HotelPrice","$HotelRate")''';
    var hotelResult = await db!.rawInsert(hotelValue);
  }
}



// class MyDb1 {
//   late Database db1;

//   Future open() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'hotel.db');
//     print("Hotel : $path");

//     db1 = await openDatabase(path, version: 1,
//         onCreate: (Database db1, int version) async {
//       // When creating the db, create the table
//       await db1.execute('''
//                     CREATE TABLE IF NOT EXISTS hotel(
//                           id INTEGER PRIMARY KEY AUTOINCREMENT,
//                           name varchar(255) not null,
//                           location varchar not null,
//                           price varchar not null,
//                           rate varchar not null,
//                           image varchar not null
//                           );
//                       //create more table here
//                   ''');

//       print("Table Created");
//     });
//   }
// }

// class MyDb2 {
//   late Database db;

//   Future open() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'place.db');
//     print("Place : $path");

//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       // When creating the db, create the table
//       await db.execute('''
//                     CREATE TABLE IF NOT EXISTS defaultdata(
//                           id INTEGER PRIMARY KEY,
//                           catogery varchar not null,
//                           name varchar(255) not null,
//                           location varchar not null,
//                           image varchar not null
//                           );
//                       //create more table here
//                   ''');

//       print("Table Created");
//     });
//   }
// }
