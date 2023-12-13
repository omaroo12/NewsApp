
import 'package:firstproj/modules/scienceNews/scienceNews.dart';
import 'package:firstproj/modules/search/searchScreen.dart';
import 'package:firstproj/modules/sportsNews/sportsNews.dart';
import 'package:firstproj/shared/comp/components.dart';
import 'package:firstproj/shared/network/remote/deoHelper.dart';
import 'package:firstproj/shared/newsCubit/NewsCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/appCubit.dart';
import '../shared/newsCubit/states.dart';

class NewsAppLayout extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
 return BlocConsumer<NewsCubit,NewsStates>(
  listener:(context,state){} ,
   builder: (context,state){
    var cubit=NewsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'News App'
        ),
        actions: [
        IconButton(onPressed: (){
          navigate(context, SearchScreen());
        }, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: (){
            AppCubit.get(context).changeMood();
          }, icon: Icon(Icons.brightness_2_outlined)),

        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items:cubit.navBarItems,
        currentIndex: cubit.currIndex,
        onTap: (int index)
          {
            cubit.onTap(index);
          }

      ),

      body:  cubit.screens[cubit.currIndex],

    );
   }


 );
  }
  
}