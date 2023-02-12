import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todoapp/wzkor/models/asmaa_allah_model.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class asmaaAllahScreen extends StatelessWidget {
  const asmaaAllahScreen({Key? key}) : super(key: key);

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
            body: SingleChildScrollView(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أسماء الله الحسني',
                      style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'إن لله تسع وتسعون اسماً من احصاها دخل الحنة',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 10,),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildWzkorAsmaaAllahItem(
                          context, cubit, cubit.asmaaAllah[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: cubit.asmaaAllah.length)
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  Widget buildWzkorAsmaaAllahItem(context, WzkorCubit cubit, AsmaaAllahModel model) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black45, width: 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              model.text!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Share.share(
                          "${model.name}\n${model.text}\n  \n نزل تطبيق وذكر الان وابدأ الذكر !.. شكرا");
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 30,
                    ),
                  color: Theme.of(context).canvasColor,
                ),
                Spacer(),
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: "${model.name}\n${model.text}"));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: HexColor("00ADB5"),
                          content: const Text(
                            'تم النسخ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )));
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 30,
                    ),
                  color: Theme.of(context).canvasColor,
                ),
              ],
            ),
          ],
        ),
      );
}
