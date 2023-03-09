import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todoapp/wzkor/models/azkar_model.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class zekrPageScreen extends StatelessWidget {

  const zekrPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WzkorCubit, WzkorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WzkorCubit cubit = WzkorCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: buildWzkorAppBarBack(context,cubit),
            body: BuildCondition(
              condition: cubit.azkarList.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildWzkorZekrItem(context,cubit.azkarList[index], cubit, state),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: cubit.azkarList.length),
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
            )

          ),
        );
      },
    );
  }

  Widget buildWzkorZekrItem(context,AzkarModel model,WzkorCubit cubit,state) => InkWell(
    child:Container(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45,width: 1)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(model.zekr!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 22
            ),
          ),
          Text(model.description! == '' ? model.category! : model.description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 22
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Share.share("${model.zekr!}\n  \n نزل تطبيق وذكر الان وابدأ الذكر !.. شكرا");
              },color: Theme.of(context).canvasColor, icon: const Icon(Icons.share,size: 30,)),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(value: 1,color: Theme.of(context).primaryColor.withOpacity(0.3),),
                  CircularProgressIndicator(value: (cubit.azkars[model.zekr]!.toDouble())/model.count!+0.03,color: Theme.of(context).primaryColor,),
                  if((model.count! == (cubit.azkars[model.zekr]!.toDouble())) || (model.count! < (cubit.azkars[model.zekr]!.toDouble())))
                    Icon(Icons.done,size: 30,color: Theme.of(context).primaryColor,),
                  if((model.count! > (cubit.azkars[model.zekr]!.toDouble())))
                    Text('${(model.count! - (cubit.azkars[model.zekr]!.toInt())).toInt()}',style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              IconButton(onPressed: () async {
                await Clipboard.setData(ClipboardData(text: "${model.zekr}\n${model.description! == '' ? model.category! : model.description!}"));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: HexColor("00ADB5"),content: const Text('تم النسخ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)));
              },color: Theme.of(context).canvasColor, icon: const Icon(Icons.copy,size: 30,)),
            ],
          ),
        ],
      ),
    ),
    onTap: (){
      cubit.changeNum(model.zekr!);
    },
  );

}
