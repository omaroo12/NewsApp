import 'package:bloc/bloc.dart';
import 'package:firstproj/shared/cubit/states.dart';
import 'package:firstproj/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


import '../newsCubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  bool isDark=false;
  void changeMood( { bool? fromRecent})
  {
    if (fromRecent!=null)
      {
        isDark=fromRecent;
      }
    else{ isDark=!isDark;}

    Cache_Helper.putData('isDark', isDark).then((value) {
      emit(MoodChangeState());
    });

  }

  List<Map> archieveTasks=[];
  List<Map> doneTasks=[];
  List<Map> newTasks=[];

  late Database db;
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  List<Widget> screens=[

  ];
  List<String> titles=[
    'NEW TASKS','DONE Tasks','Archieved Tasks'
  ];
  int currentIndex=0;
  void changeScreen(int index)
  {
    currentIndex=index;
    emit(AppBottmBarChangeState());
  }
  void createDataBase()
  {
     openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version)  {
        print("Data Base Created");
         db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date Text,status TEXT,time TEXT)");
        print("Table Created");
      },
      onOpen: (db) {
        getDataFromDataBase(db);

      },).then((value) {
      db = value;
      emit(AppCreateDataBase());
    });
  }
void getDataFromDataBase(db) async
  {
    newTasks=[];
    archieveTasks=[];
    doneTasks=[];

emit(AppLoadingBar());
     db.rawQuery("select * from tasks").then((value) {
     value.forEach((element)
     {
       if(element['status']=='done')
         {
           doneTasks.add(element);
         }
      else if(element['status']=='new')
       {
         newTasks.add(element);
       }
      else
        {
          archieveTasks.add(element);
        }

     });

       emit(AppGetFromDataBase());
     });

  }


  Future  insertDataBase({
    required String date ,required String title ,required String time}
      ) async
  {

    return await db.transaction(
            (txn)
        => txn.rawInsert("INSERT INTO tasks(time, date, status, title) VALUES('${time}', '${date}', 'new', '${title}')").then((value) {
          emit(AppInsertDataBase());
          getDataFromDataBase(db);
          print('$value added sucess');
        }).catchError((error){

        }));


  }
  void updateDataBase(@required String status,@required int id) async
  {
     db.rawUpdate('UPDATE tasks SET status=? WHERE id=?',[status,id]).then((value)
     {

       emit(AppUpdateDataBase());
       getDataFromDataBase(db);


     });
  }
  void deleteDataBase(@required int id) async
  {
    db.rawUpdate('DELETE FROM tasks  WHERE id=?',[id]).then((value)
    {

      emit(AppDeleteFromDatabase());
      getDataFromDataBase(db);


    });
  }





  }
