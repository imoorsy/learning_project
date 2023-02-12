import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/models/shop_search_model.dart';
import 'package:todoapp/shared/componants/componants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                )),
            leadingWidth: 80,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Search',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  defaultTextFormField(context,
                      controller: cubit.oldPasswordController,
                      keyboardtype: TextInputType.text,
                      validator: (value) {}, onchange: (value) {
                    cubit.getSearch(value.toString());
                  },
                      autofocus: true,
                      prefix: Icons.search,
                      labelText: 'search for products ...'),
                  SizedBox(
                    height: 30,
                  ),
                  BuildCondition(
                    condition: state is! ShopLoadingGetSearchState && cubit.shopSearchModel != null,
                    builder: (context) => ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildSearchItem(
                            context,
                            cubit.shopSearchModel!.data!.data![index],
                            cubit),
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey,
                            ),
                        itemCount: cubit.shopSearchModel!.data!.data!.length),
                    fallback: (context) => Center(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchItem(context, SearchItemData model, ShopCubit cubit) =>
      Container(
        color: Colors.white,
        width: double.infinity,
        height: 150,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            CachedNetworkImage(
              imageUrl: model.image!,
              errorWidget: (context, text, dynamic) => Image.asset(
                "assets/image/PngItem_5585968.png",
                width: 150,
                height: 150,
              ),
              progressIndicatorBuilder: (context, msg, progress) => Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              )),
              width: 150,
              height: 150,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    model.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20.0, height: 1.3),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        '${model.price}\$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.0, color: Colors.amber),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(model.id!, context);
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 40,
                          color: cubit.favorites[model.id]! ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
