import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/layout/news_layout/news_layout.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/layout/shop_layout/shop_layout.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/layout/sport_layout/sport_layout.dart';
import 'package:todoapp/layout/todo_layout/todo_layout.dart';
import 'package:todoapp/modules/news_app/search_screen/search_screen.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/modules/shop_app/onbording_screen/onbording_screen.dart';
import 'package:todoapp/modules/zekr_app//zekr_main/zekr_main_screen.dart';
import 'package:todoapp/modules/zekr_app//zekr_screen/cubit/cubit.dart';
import 'package:todoapp/modules/zekr_app//zekr_screen/cubit/states.dart';
import 'package:todoapp/modules/zekr_app//zekr_screen/zekr_screen.dart';

import 'package:todoapp/shared/bloc_observer.dart';
import 'package:todoapp/shared/componants/constants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';
import 'package:todoapp/wzkor/layout/wzkor_layout.dart';
import 'package:todoapp/wzkor/shared/bloc_observer.dart';
import 'package:todoapp/wzkor/shared/componants/constants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

// *****************Wzkor App ***************************

void main() async {
  Bloc.observer = WzkorBlocObserver();
  DioHelper.init();
  // Use cubits...
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<WzkorCubit>(
//       create: (context) => WzkorCubit(),
//       child: BlocConsumer<WzkorCubit, WzkorStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           WzkorCubit cubit = WzkorCubit.get(context);
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             // theme: cubit.isLight ? wzkorLight : wzkorDark,
//             home: SportLayout(),
//           );
//         },
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SportCubit()..getMatchCenter(date: editDateFormat(todayDate)),
      child: BlocConsumer<SportCubit,SportStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: cubit.isLight ? wzkorLight : wzkorDark,
          home: SportLayout(),
        );
        },
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   Bloc.observer = MyBlocObserver();
//   DioHelper.init();
//   await cacheHelper.init();
//
//   bool? isdark = cacheHelper.getData(key: 'isDark');
//   bool? onboarding = cacheHelper.getData(key: 'onBoarding');
//   token = cacheHelper.getData(key: 'token')??'';
//   Widget startwidget = OnboardingScreen();
//
//   if(onboarding != null) {
//     if(token != '') {
//       startwidget = ShopLayout();
//     } else {
//       startwidget = ShopLoginScreen();
//     }
//   } else {
//     startwidget = OnboardingScreen();
//   }
//
//   // Use cubits...
//   runApp(MyApp(
//     isDark: isdark,
//     startWidget: startwidget,
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   final bool? isDark;
//   final Widget? startWidget;
//   MyApp({this.isDark,this.startWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ShopCubit>(
//       create: (BuildContext context) => ShopCubit()
//         ..getCategories()
//         ..getStartData(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: shopLightTheme,
//         home: startWidget,
//       ),
//     );
//   }
// }
