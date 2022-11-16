


import 'package:app01/layout/shop_app/cubit/cubit.dart';
import 'package:app01/layout/shop_app/cubit/states.dart';
import 'package:app01/models/shopp_app/home_model.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopp_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopSuccessFavoritesStates)
        {
          if(!state.model.status){
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          }

        }

      },
      builder: (context,state)=> ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null &&ShopCubit.get(context).categoriesModel != null,
        builder: (context) => productBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel !,context),
        fallback: (context) => Center(child: CircularProgressIndicator()),

      )
    );
  }
  Widget productBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model.data.banners.map((e) =>Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.contain,
            ),).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0
            ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategorieItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data!.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
              crossAxisCount:2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.72,

              children:
                List.generate(
                    model.data.products.length,
                        (index) => buildGridProduct(model.data.products[index],context),
                ),

          ),
        ),



      ],
    ),
  );

Widget buildGridProduct(ProductModel model,context)=>Container(
  color: Colors.white,
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,


    children: [

      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
          image: NetworkImage(model.image!),
            width: double.infinity,
            height: 200.0,

          ),
          if(model.discount !=0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              color: Colors.deepOrange,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white
                ),
              ),
            ),
          )
        ]
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',

                  style: TextStyle(
                    fontSize: 12.0,
                    color: defaultcolor,

                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if(model.discount !=0)
                  Text(
                  '${model.oldPrice.round()}',

                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,

                  ),
                ),
                Spacer(),
                IconButton(

                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ?defaultcolor: Colors.grey,
                      child:Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ) ,
                    ),

                ),

              ],
            ),
          ],
        ),
      ),



    ],

  ),
);
}
 Widget buildCategorieItem(DataModel model)=>Stack(
   alignment: Alignment.bottomLeft,
   children: [
     Image(
       image: NetworkImage(model.image!),
       height: 100.0,
       width: 100.0,
       fit: BoxFit.cover,
     ),
     Container(
       color: Colors.black.withOpacity(0.7),
       width: 100,
       child: Text(
         model.name!,
         style: TextStyle(
           color: Colors.white,
           overflow: TextOverflow.ellipsis,

         ),
       ),
     ),
   ],
 );