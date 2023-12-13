import 'package:firstproj/shared/cubit/appCubit.dart';
import 'package:flutter/material.dart';



Widget defaultTextFormField({required TextEditingController controller,
    required TextInputType textInput,
    required String labelText,
     Function? onSubmit,
    Function? onChange,
  Function? onTap,
    required Function validate,
    required IconData prefixIconn,
  }





    )
{
  return TextFormField(
    controller: controller,
    keyboardType: textInput,
    decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIconn
        ),






    ),
    onTap: (){
      onTap?.call();
    },
    onChanged: (value){
      onChange?.call(value);
    },
    onFieldSubmitted: (value){
      onSubmit?.call(value);
    },


  );
}
void navigate(context,widget)
{
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=>widget));

}

Widget buildNewsItem( context,business)
{
  return    InkWell(
    onTap: (){

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
               ),
               child: Image.network('${business['urlToImage']}'),

// i want full url

            ),

          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(

                      '${business['title']}',
                      style: Theme.of(context).textTheme.displayLarge,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text('${business['publishedAt']}'
                      ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),


                ],
              ),
            ),
          ),
        ],

      ),
    ),
  );
}
Widget buildItemTask(Map map,context)
{
  return   Dismissible(
    key: Key(

      map['id'].toString()
    ),
    onDismissed: (direction){
      AppCubit.get(context).deleteDataBase(map['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(
                '${map['time']}'
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              children: [
                Text('${map['date']}'),
                SizedBox(
                  height: 20,
                ),
                Text('${map['title']}'),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: (){ AppCubit.get(context).updateDataBase('done', map['id']);},
              icon: Icon(
                Icons.done
              ),
          ),
          IconButton(
            onPressed: (){
              AppCubit.get(context).updateDataBase('archieved', map['id']);
            },
            icon: Icon(
                Icons.edit
            ),
          )

        ],


      ),
    ),
  );

}