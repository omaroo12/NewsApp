import 'package:firstproj/shared/comp/components.dart';
import 'package:firstproj/shared/newsCubit/NewsCubit.dart';
import 'package:firstproj/shared/newsCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceNews extends StatelessWidget {
  const ScienceNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context,state){return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildNewsItem(context,NewsCubit.get(context).science[index]),
          separatorBuilder: (context,index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          itemCount: NewsCubit.get(context).science.length);},
      listener: (context,state){},

    );

  }
}
