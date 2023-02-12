import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/shared/componants/componants.dart';

class searchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();


  var formSearchKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<newsCubit,newsStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = newsCubit.get(context);
          List searchList = cubit.Searched;
          return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formSearchKey,
                    child: defaultSearchFormField(
                      context,
                        controller: searchController,
                        keyboardtype: TextInputType.text,
                        submitFunction: (value){
                        if(formSearchKey.currentState!.validate()){
                          searchController.text = value;
                          cubit.getSearched(value);
                        }
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        prefix: Icons.search,
                        labelText: "إبحث عن اهم الاخبار ..."),
                  ),
                ),
                BuildCondition(
                  condition: searchList.isNotEmpty,
                  builder:(context) => Text("${searchList.length} result found",textDirection: TextDirection.ltr,style: Theme.of(context).textTheme.headline1,),
                  fallback: (context) => Container(),
                ),
                BuildCondition(
                  condition: state is newsSearchLoadingStates,
                  fallback: (context) => BuildCondition(
                    condition: state is newsGetSearchSuccessStates && searchList.isNotEmpty,
                    builder:(context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildNewsAppItem(searchList[index] , context),
                        separatorBuilder:(context, index) => Container(width: double.infinity,height: 1,color: Colors.grey,),
                        itemCount: searchList.length
                    ),
                    fallback: (context) => Center(child: Text("No Data",style: Theme.of(context).textTheme.headline1,)),
                  ),
                  builder: (context) => Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
