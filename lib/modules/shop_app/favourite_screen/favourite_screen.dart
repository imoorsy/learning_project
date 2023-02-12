import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/models/favorites_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return BuildCondition(
          condition: cubit.favoritesModel != null && cubit.favoritesModel!.data!.data!.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Favourite",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 1 / 1.6,
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.favoritesModel!.data!.data!.length,
                          (index) => buildFavProductBuilder(context,cubit.favoritesModel!.data!.data![index],cubit),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback:(context) => BuildCondition(
            condition: state is ShopSuccessFavoritesState && cubit.favoritesModel!.data!.data!.isEmpty ,
            fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.amber,)),
            builder: (context) => Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.heart_broken,size: 200,color: Colors.red,),
                Text('No Favorites add some !',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            )),
          ),
        );
        },
    );
  }

  Widget buildFavProductBuilder(context,FavoritesData model, ShopCubit cubit) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CachedNetworkImage(
                  imageUrl: model.product!.image!,
                  errorWidget: (context, text, dynamic) => Image.asset(
                    "assets/image/PngItem_5585968.png",
                    width: double.infinity,
                  ),
                  progressIndicatorBuilder: (context, msg, progress) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      )),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.product!.discount! != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      "خصم ${model.product!.discount!}%",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20.0, height: 1.3),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${model.product!.price!}\$',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0, color: Colors.amber),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.product!.discount! != 0)
                    Text(
                      '${model.product!.oldPrice!}\$',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      cubit.changeFavorites(model.product!.id!, context);
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 40,
                      color: cubit.favorites[model.product!.id!]!
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}