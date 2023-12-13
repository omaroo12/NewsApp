import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firstproj/shared/blocObserver.dart';
import 'package:firstproj/shared/cubit/appCubit.dart';
import 'package:firstproj/shared/cubit/states.dart';
import 'package:firstproj/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:firstproj/shared/network/remote/deoHelper.dart';
import 'package:firstproj/shared/newsCubit/NewsCubit.dart';
import 'package:firstproj/shared/newsCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/newsAppLayout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=SimpleBlocObserver();
  DiOHelper.init();
  await Cache_Helper.init();
  bool? isDark = Cache_Helper.getData('isDark');
  isDark ??= false;


  runApp( MyApp(isDark));

}
// /https://newsap1.org/v2/everything?g=tesla&apikey=13e00ae07cb74411a1083e00ad14be71

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:[
        BlocProvider(
            create: (BuildContext context)=>NewsCubit()..getSportsData()..getBusinesData()..getScienceData()),
        BlocProvider
          (
            create: (BuildContext context)=>AppCubit()..changeMood(fromRecent
                : isDark)),

      ],

      child:  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(




            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,

              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,

              ),
              iconTheme: IconThemeData(
                  color: Colors.black
              ),

            ),
            bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black
            ),

            textTheme: TextTheme(
                displayLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,

                )
            ),

          ),
          darkTheme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.black,
            ),
            scaffoldBackgroundColor: Color(0xff333739),
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor:  Color(0xff333739),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xff333739),

              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,

              ),
              iconTheme: IconThemeData(
                  color: Colors.white
              ),

            ),
            bottomNavigationBarTheme:BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedIconTheme:IconThemeData(
                  color: Colors.grey

              ),


              backgroundColor:  Color(0xff333739),


            ),
            textTheme: TextTheme(
                displayLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,

                )
            ),

          ),
          themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

          home: NewsAppLayout(),
        ),

      ),
    );
  }
}

