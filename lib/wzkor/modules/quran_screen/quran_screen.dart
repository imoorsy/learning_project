import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/models/soura_model.dart';
import 'package:todoapp/wzkor/modules/soura_page/soura_page_screen.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class quranScreen extends StatelessWidget {
  const quranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<WzkorCubit,WzkorStates>(
        listener: (context,state) {},
        builder: (context,state) {
          WzkorCubit cubit = WzkorCubit.get(context);
          List<Soura> list = cubit.souras;
          return Scaffold(
          appBar: buildWzkorAppBarBack(context,cubit),
          body: BuildCondition(
            condition: state is CollectQuranLoadingStates && cubit.souras.isEmpty,
            builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
            fallback: (context) => SingleChildScrollView(
              child: Column(
                children: [
                Container(
                height: 75,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child:   GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  children: [
                    const Text(
                      "رقم السورة",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Text("إسم السورة",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const Text("مكان نزولها",style: TextStyle(fontSize: 20,color: Colors.black),),
                    const Text("عدد الايات",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ],
                ),
              ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index) => buildWzkorQuranItem(list[index],context),
                      separatorBuilder: (context,index) => Container(width: double.infinity,height: 2,color: Colors.black,),
                      itemCount: list.length),
                ],
              ),
            ),
          ),
        );
        },
      ),
    );
  }

  Widget buildWzkorQuranItem(Soura souraitem, context) => GestureDetector(
    child:   Container(
      height: 75,
      padding: const EdgeInsets.all(20),
      child:   GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        children: [
          Text(
            souraitem.id.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(souraitem.name.toString(),
              style: Theme.of(context).textTheme.titleMedium),
          Text(souraitem.type.toString(),
              style: Theme.of(context).textTheme.titleMedium),
          Text(souraitem.array!.length.toString(),
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => souraPageScreen(souraitem: souraitem,)));
    },
  );
}
