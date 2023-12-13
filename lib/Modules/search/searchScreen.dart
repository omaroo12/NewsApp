import 'package:firstproj/shared/comp/components.dart';
import 'package:firstproj/shared/newsCubit/NewsCubit.dart';
import 'package:firstproj/shared/newsCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var searchController=TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
        {
          var list=NewsCubit.get(context).search;
          return    Scaffold(

              appBar: AppBar(),
              body:Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultTextFormField(controller: searchController, textInput: TextInputType.text, labelText: 'Search',
                      validate: (String value){
                        return !(value.isEmpty)?null:'Search must not be empty';

                      },

                       prefixIconn: Icons.search,
                        onChange: (value){
                          NewsCubit.get(context).getSearchData(value);
                        },






                        ),


                  ),
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildNewsItem(context,list[index]),
                        separatorBuilder: (context,index)=>Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                        itemCount: list.length),
                  ),
                ],
              )
          );
        }
       
    );
  }
}
