import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/soura_model.dart';
import 'package:todoapp/wzkor/models/asmaa_allah_model.dart';
import 'package:todoapp/wzkor/models/azkar_model.dart';
import 'package:todoapp/wzkor/modules/about_screen/about_screen.dart';
import 'package:todoapp/wzkor/modules/home_screen/home_screen.dart';
import 'package:todoapp/wzkor/modules/listen_screen/listen_screen.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class WzkorCubit extends Cubit<WzkorStates> {
  WzkorCubit() : super(WzkorInitialStates());

  static WzkorCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<BottomNavigationBarItem> bottomBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.queue_music),
      label: "إستمع",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: "الرئيسية",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "الإعدادات",
    ),
  ];

  List<Widget> screen = [
    const ListenScreen(),
    HomeScreen(),
    const AboutScreen(),
  ];

  static const morningZekr = "assets/azkar_morning.json";
  static const nightZekr = "assets/azkar_night.json";
  static const prayerZekr = "assets/azkar_pryer.json";
  static const sleepZekr = "assets/azkar_sleep.json";
  static const generalZekr = "assets/all_azkar.json";


  List<Map<String,dynamic>> azkarItems = [
    {
      "title":"اذكار الصباح",
      "subtitle":"بين الفجر والمغرب",
      "image":"assets/image/outside_mosque.jpg",
      "file_path" : morningZekr
    },
    {
      "title":"اذكار المساء",
      "subtitle":"بين المغرب والفجر",
      "image":"assets/image/inside_mosque2.jpg",
      "file_path" : nightZekr
    },
    {
      "title":"اذكار الصلاة",
      "subtitle":"الاذكار بعد الصلاة المفروضة",
      "image":"assets/image/prayer_in_dessert.jpg",
      "file_path" : prayerZekr
    },
    {
      "title":"اذكار النوم",
      "subtitle":"أذكار عند النوم",
      "image":"assets/image/man_hold_sepha.jpg",
      "file_path" : sleepZekr
    },
    {
      "title":"اذكار عامة",
      "subtitle":"الاذكار بعد الصلاة المفروضة",
      "image":"assets/image/quran_sepha.jpg",
      "file_path" : generalZekr
    },
  ];

  // Json File
  String fileText = ""; // String to store Json Data
  List<Soura> souras = <Soura>[]; // List to store Parsed Json Data
  List<AsmaaAllahModel> asmaaAllah = [];
  List<AzkarModel> azkarList = [];

  readFile(String jsonfile) async {
    var text = await rootBundle.loadString(jsonfile);
    fileText = text;
  }

  Map<String, int> azkars = {};
  // Get Azkar Json File Data
  parseJson() {
    final parsed = json.decode(fileText).cast<Map<String, dynamic>>();
    azkarList = parsed.map<AzkarModel>((json) => AzkarModel.fromJson(json)).toList();
    for (var element in azkarList) {
      azkars.addAll({
        element.zekr!: 0,
      });
    }
  }

  getData(String jsonfile) async {
    emit(CollectZekrLoadingStates());
    azkarList = [];
    await readFile(jsonfile);
    await parseJson();
    emit(CollectZekrSuccessStates());
  }

  // Get Quran Json File Data
  parseQuranJson() {
    final parsed = json.decode(fileText).cast<Map<String, dynamic>>();
    souras = parsed.map<Soura>((json) => Soura.fromJson(json)).toList();
  }

  parseAsmaaAllahJson() {
    final parsed = json.decode(fileText).cast<Map<String, dynamic>>();
    asmaaAllah = parsed.map<AsmaaAllahModel>((json) => AsmaaAllahModel.fromJson(json)).toList();
  }

  getQuran() async {
    emit(CollectQuranLoadingStates());
    if (souras.isEmpty){
      await readFile("assets/Quran.json");
      await parseQuranJson();
      emit(CollectQuranSuccessStates());
    } else {
      emit(CollectQuranSuccessStates());
    }
  }
  void getAsmaaAllah() async {
    emit(CollectAsmaaAllahLoadingStates());
    if (souras.isEmpty){
      await readFile("assets/Names_Of_Allah.json");
      await parseAsmaaAllahJson();
      print(asmaaAllah.first.text);
      emit(CollectAsmaaAllahSuccessStates());
    } else {
      emit(CollectAsmaaAllahSuccessStates());
    }
  }


  void changeIndex (int index) {
    currentIndex = index;
    emit(ChangeBarIndexStates());
  }
  void changeNum(String zekr) {
    azkars[zekr] = azkars[zekr]! + 1 ;
    emit(ChangeZekrCountStates());
  }

  bool isLight = true;
  void changeTheme(){
    isLight = !isLight;
    emit(ChangeModeStates());
  }
}