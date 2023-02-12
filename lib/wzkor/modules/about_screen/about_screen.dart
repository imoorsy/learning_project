import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "تطبيق واذْكر هو تطبيق إسلامي الغرض منة تمكين المسلمين من ذكر الله في هذا الزمن المليء بالتكنولوجيا والسرعة ونتمني ان يوفقنا الله لذالك",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "وَاذْكُرْ",
                style: Theme.of(context).textTheme.labelLarge,

              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.remove_red_eye,size: 30,),
              title: Text('المظهر ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.arrow_forward_ios,size: 30,),
              iconColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.settings,size: 30,),
              title: Text('الإعدادات',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.arrow_forward_ios,size: 30,),
              iconColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.call,size: 30,),
              title: Text('تواصل معنا',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.arrow_forward_ios,size: 30,),
              iconColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
