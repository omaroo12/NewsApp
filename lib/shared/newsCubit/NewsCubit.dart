import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firstproj/modules/search/searchScreen.dart';
import 'package:firstproj/shared/newsCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Modules/businessNews/businessNews/businessNews.dart';
import '../../modules/scienceNews/scienceNews.dart';
import '../../modules/sportsNews/sportsNews.dart';
import '../network/remote/deoHelper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitalState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  bool isDark = false;
  int currIndex=0;
  List<Widget> screens=
  [
    SportsNews(),
    ScienceNews(),
    BusinessNews(),

  ];
  List<BottomNavigationBarItem> navBarItems=[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,

        ),
      label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,

        ),
        label: 'Science'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,

        ),
        label: 'Business'
    ),

  ];
  void onTap(index)
  {
    currIndex=index;
    if(index==1)
      getScienceData();
    else if(index==2)
      getBusinesData();
    else if(index==0)
      getSportsData();
    emit(NewsBottomNavBar());
  }
  List<dynamic> business=[];
  void getBusinesData()
  {
    emit(NewsLoadingState());
    DiOHelper.getData(
        '/v2/top-headlines',
        {
          'country':'us',
          'category':'business',
          'apiKey': '13e00ae07cb74411a1083e00ad14be71',

        }
    ).then((value) {business=value.data['articles']

    ;

    emit(BusinessStateSucess());}).catchError((error){
      emit(BusinessStateErorr());
      print(error.toString());
    });
  }
  List<dynamic> sports=[];
  void getSportsData()
  {
    emit(NewsLoadingState());
    DiOHelper.getData(
        'v2/top-headlines',
        {
          'country':'us',
          'category':'sports',
          'apiKey': '13e00ae07cb74411a1083e00ad14be71',

        }
    ).then((value) {sports=value.data['articles']

    ;

    emit(SportsStateSucess());}).catchError((error){
      emit(SportsStateErorr());
      print(error.toString());
    });
  }
  List<dynamic> science=[];
  void getScienceData()
  {
    emit(NewsLoadingState());
    DiOHelper.getData(
        'v2/top-headlines',
        {
          'country':'us',
          'category':'science',
          'apiKey': '13e00ae07cb74411a1083e00ad14be71',

        }
    ).then((value) {science=value.data['articles']

    ;

    emit(ScienceStateSucess());}).catchError((error){
      emit(ScienceStateErorr());
      print(error.toString());
    });
  }
  List<dynamic> search=[];
  void getSearchData(String value){

    //https://newsapi.org/v2/everything?q=tesla&from=2023-11-05&sortBy=publishedAt&apiKey=13e00ae07cb74411a1083e00ad14be71
    emit(SearchStateLoading());
    DiOHelper.getData(
        'v2/everything',
        {

          'q':'$value',
          'apiKey': '13e00ae07cb74411a1083e00ad14be71',

        }

    ).then((value) {search=value.data['articles'];
    print('my list is $search');




    emit(SearchStateSucess());}).catchError((error){
      emit(SearchStateErorr());
      print(error.toString());
      print('no Lis');
    });



  }

}
