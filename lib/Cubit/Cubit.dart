import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/States.dart';
import 'package:work_time_calculator/Screens/CheckInOut/CheckInOut.dart';
import 'package:work_time_calculator/Screens/History/History.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';

class AppCubit extends Cubit<states> {
  AppCubit() : super(InitialState());

  static AppCubit getCubit(context) => BlocProvider.of(context);
  final number = 20;
  bool isStart = false;
  List<String> appBarTitle = ['CHECK IN', 'HISTORY'];
  List<Widget> screenBody = [CheckInOut(), History()];
  int appBarIndex = 0;
  void changeTopBar(int index) {
    emit(ChangeTopBarIndexState());
    appBarIndex = index;
  }

  void changeIsPressed(bool value) {
    if (value) {
      CashHelper.saveData(key: 'isPressed', value: value);
      print(CashHelper.getData(key: 'isPressed'));
      print('printed after change isPressed to true');

      emit(ChangeIsPressedToTrueState());
    } else {
      CashHelper.saveData(key: 'isPressed', value: value);
      print(CashHelper.getData(key: 'isPressed'));
      print('printed after change isPressed to false');

      emit(ChangeIsPressedToFalseState());
    }
  }

  var myDB;

  void createDB() async {
    myDB = await openDatabase('app.db', version: 1,
        onCreate: (database, version) async {
      print('creating database');
      database
          .execute(
              'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, $startTime TEXT, $endTime TEXT,$date TEXT)')
          .then((value) {
        print('table created');
        emit(CreateDataBaseState());
      }).catchError((error) {
        print("error found on DB is : $error");
      });
    }, onOpen: (database) {
      readFromDB(database);
      print("DB is opened");
      emit(OpenDataBaseState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCreateDataBaseState());
    });
  }

  List times = [];
  void readFromDB(database) async {
    times = await database.rawQuery('select * from "$tableName"');
    print(times);
    emit(ReadFromDataBaseState());
  }

  void insertToDB({
    required var startTimee,
    required var endTimee,
    required var datee,
  }) async {
    myDB.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO "$tableName" ("$startTime","$endTime","$date") VALUES("$startTimee","$endTimee","$datee")')
          .then((value) {
        print('row number $value inserted Successfully');
        readFromDB(myDB);
        emit(InsertInDataBaseState());
      }).catchError((onError) {
        print("error found on DB is : $onError");
      });
    });
  }

  void deleteFromDataBase(int id) async {
    await myDB.rawDelete('DELETE FROM "$tableName" WHERE id = "$id"');
    readFromDB(myDB);
    emit(DeleteDataBaseState());
  }
}
