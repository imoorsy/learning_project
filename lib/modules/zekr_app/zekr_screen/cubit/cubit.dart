import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/zekr_model.dart';
import 'package:todoapp/modules/zekr_app/zekr_screen/cubit/states.dart';

class zekrCubit extends Cubit<zekrStates> {
  zekrCubit() : super(zekrInitialStates());

  static zekrCubit get(context) => BlocProvider.of(context);

  static var time = DateTime.now();

  String azanZekr = "assets/azkar_azan.json";
  String generalZekr = "assets/azkar_general.json";
  String clothZekr = "assets/azkar_cloth.json";
  String homeZekr = "assets/azkar_home.json";
  String morningZekr = "assets/azkar_morning.json";
  String nightZekr = "assets/azkar_night.json";
  String prayerZekr = "assets/azkar_pryer.json";
  String sleepZekr = "assets/azkar_sleep.json";
  String wakupZekr = "assets/azkar_wakup.json";
  String wodoaZekr = "assets/azkar_wodoa.json";


  void changeZekr(){
    emit(changezekrStates());
  }
  void changecounter(){
    emit(changeCounterStates());
  }

  void goToZekr(String jsonfile){
    getData(jsonfile);
    emit(changePageZekr());
  }

  Future<void> getJsonData(List<dynamic> list) async{
    final String response = await rootBundle.loadString('assets/azkar_azan.json');
    final date = json.decode(response);
    list = date['azkar'];
    print('zekr ready ${list.length}');
    emit(changezekrStates());
  }
// Json File
  String fileText = ""; // String to store Json Data
  List<Zekr> zekrs = <Zekr>[]; // List to store Parsed Json Data

  readFile(String jsonfile) async {
  String text = await rootBundle.loadString(jsonfile);
      fileText = text;
  }

  parseJson() {
    final parsed = json.decode(fileText).cast<Map<String, dynamic>>();
    zekrs = parsed.map<Zekr>((json) => Zekr.fromJson(json)).toList();
  }

  getData(String jsonfile) async {
      await readFile(jsonfile);
      await parseJson();
    emit(collectzekrSuccessStates());
  }
}