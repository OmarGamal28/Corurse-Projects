//import 'package:flutter/cupertino.dart';
//import 'package:conditional_builder/conditional_builder.dart';

import 'package:app01/moduels/news_app/web_view/web_view_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/shopp_app/favorites_model.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width= double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius =10.0,
  required Function function,
  required String text,

}
)=>
    Container(

      width: width,

      child: MaterialButton(onPressed: ()
      {
        function();
        },
        child: Text(
          isUpperCase?  text.toUpperCase() : text,
          style: TextStyle(
          color: Colors.white
      ),
    ),
  ),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,//لازم الكولور جوه طالاما عملت بوكس ديكوريشن
      ),
);
Widget defaultTextButton ({
  required Function function,
  required String text
})=> TextButton(onPressed:(){
  function();
} ,
    child: Text(text.toUpperCase())
);

Widget defaultFormField({
  required TextEditingController control,
  required TextInputType type,
  required FormFieldValidator <String> validate,
  Function? onSumbit,
  Function? onChange,
  required String label,
  required IconData prefixicon,
  bool isPass = false ,
  IconData? sufix,
  Function? sufixxpresed,
  Function? onTap,

}) => TextFormField(
  controller: control ,//بتتحكم في الكلام الي جوه
  keyboardType: type,
  obscureText: isPass,
  onTap:(){
    onTap!();
  },

  onFieldSubmitted: (String value){
     //لما اخلص كتابه اطبع
    onSumbit!(value);
  },
  onChanged: (s){
    onChange!(s);//بيطبع طول ما بكتب
  },
  validator: validate,
  decoration: InputDecoration(
    labelText: label,//الي بيبقي مكتوب علي المكان
    border: OutlineInputBorder(),//بيظبط الحواف
    prefixIcon: Icon(
      prefixicon,
    ),
    suffixIcon: sufix !=null ? IconButton(
        icon: Icon(sufix,),
      onPressed: (){
          sufixxpresed!();
      },
    ): null,//اول ايكون
  ),
);
Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id']),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child:Text(

            '${model['time']}',

            style: TextStyle(



            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 20.0,

                ),

              ),

              Text(

                '${model ['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: ()

            {

              AppCubit.get(context).updateData(status: 'done', id: model['id']);

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.green,

            )

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'archive', id: model['id']);

            },

            icon: Icon(

                Icons.archive,

              color: Colors.grey,

            )

        ),

      ],

    ),

  ),
);
Widget buildArticleItem(article,context)=> InkWell(
  onTap: (){
navigateTp(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  children:[

  Container(

  width: 120,

  height: 120,

  decoration: BoxDecoration(

  borderRadius: BorderRadius.circular(10.0),

  image: DecorationImage(

  image: NetworkImage('${article['urlToImage']}'),

  fit: BoxFit.cover,

  ),

  ),

  ),

  SizedBox(

  width: 20.0,

  ),

  Expanded(

  child: Container(

  height: 120.0,

  child: Column(



  crossAxisAlignment: CrossAxisAlignment.start,

  mainAxisAlignment: MainAxisAlignment.start,

  children: [

  Expanded(

  child: Text(

    '${article['title']}',

  maxLines: 2,

  overflow: TextOverflow.ellipsis,

  style: Theme.of(context).textTheme.bodyText1,

  ),

  ),

  Text(

    '${article['publishedAt']}',

  style: Theme.of(context).textTheme.bodyText1,

  ),

  ],

  ),

  ),

  ),



  ]

  ),

  ),
);
Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(start: 10.0),
  child:   Container(
    height: 1.0,
    color: Colors.grey,
  ),
);
Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
    condition: list.length>0,
    builder: (context)=>ListView.separated(

      physics: BouncingScrollPhysics(), //عشان لما اشد الشاشه تتشد معايا من فوق
      itemBuilder: (context,index)=> buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: 11,
    ),
    fallback: (context)=> isSearch ? Container(): Center(child: CircularProgressIndicator())
);
void navigateTp(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
);
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route ) {
      return false;
}
);
void showToast ({required String text,required ToastStates state}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );

}
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
  }
  return color;

}


Widget buildListProduct( model, context,{
  bool isOldPrice= true
}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0 && isOldPrice  )
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: TextStyle(
                        fontSize: 12,
                        color: defaultcolor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0 && isOldPrice)
                    Text(model.discount.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),

                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(
                          (model.id)!
                      );
                      // print(model.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopCubit
                            .get(context)
                            .favorites[model.id]!
                            ? defaultcolor
                            : Colors.grey,
                        radius: 15,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
