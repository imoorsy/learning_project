import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/models/categories_model.dart';
import 'package:todoapp/shared/componants/componants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoryItemVertical(
                cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: 1,
                ),
            itemCount: cubit.categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget buildCategoryItemVertical(DataModel model) => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: model.image!,
              fit: BoxFit.cover,
              errorWidget: (context, text, dynamic) => Image.asset(
                "assets/image/PngItem_5585968.png",
                width: 120.0,
                height: 120.0,
              ),
              progressIndicatorBuilder: (context, msg, progress) => Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              )),
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name!,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward,
            size: 40,
          ),
        ],
      );
}
