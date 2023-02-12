import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/modules/news_app/business/business_screen.dart';
import 'package:todoapp/modules/news_app/matches_screen/matches_screen.dart';
import 'package:todoapp/modules/news_app/science/science_screen.dart';
import 'package:todoapp/modules/news_app/sports/sports_screen.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';
import 'package:todoapp/shared/network/remote/api_manager.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';

class newsCubit extends Cubit<newsStates> {
  newsCubit() : super(newsInitialStates());

  static newsCubit get(context) => BlocProvider.of(context);


  static var time = DateTime.now();
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.money),
        label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_volleyball),
        label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science',
    ),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.sports_soccer),
    //     label: 'Matches',
    // ),
  ];

  List<dynamic> Searched = [];

  Future<void> getSearched(String search) async {
    Searched.clear();
    emit(newsSearchLoadingStates());
    await DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':search,
          'sortBy':'popularity',
          'language':'ar',
          'apiKey':'be23fd46702947d2945ce4cbe065bc9b',
        }).then((value) {
      Searched = value.data['articles'];
      emit(newsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(newsGetSearchErrorStates(error));
    });
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // MatchesScreen(),
  ];

  void changeBottomNav (int index) {
    currentIndex = index;
    if(index == 0)
      getBusniss();
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    // if(index == 3)
    //   getMatches();
    emit(newsBottomNavStates());
  }

  List<dynamic> busniss = [];

  Future<void> getBusniss() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());
    if (result != ConnectivityResult.none)
      {
        busniss.clear();
        emit(newsBusnissLoadingStates());
        await DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'business',
              'apiKey':'be23fd46702947d2945ce4cbe065bc9b',
            }).then((value) {
          // print(value.data.toString());
          busniss = value.data['articles'];
          emit(newsGetBusnissSuccessStates());
        }).catchError((error) {
          print(error.toString());
          emit(newsGetBusnissErrorStates(error));
        });
      }
    else {
      emit(networkNotConnectStates(massage: "No Internet !"));
    }

  }

  List<dynamic> sports = [];

  Future<void> getSports() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());
    if (result != ConnectivityResult.none)
    {
      sports.clear();
      emit(newsSportsLoadingStates());
      await DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sport',
            'apiKey':'be23fd46702947d2945ce4cbe065bc9b',
          }).then((value) {
        sports = value.data['articles'];
        emit(newsGetSportsSuccessStates());
      }).catchError((error) {
        print('Sports Error is : ${error.toString()}');
        emit(newsGetSportsErrorStates(error));
      });
    }
    else {
      emit(networkNotConnectStates(massage: "No Internet !"));
    }

  }

  List<dynamic> science = [];

  Future<void> getScience() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());
    if (result != ConnectivityResult.none)
    {
      science.clear();
      emit(newsScienceLoadingStates());
      await DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'be23fd46702947d2945ce4cbe065bc9b',
          }).then((value) {
        science = value.data['articles'];
        emit(newsGetScienceSuccessStates());
      }).catchError((error) {
        print('Sports Error is : ${error.toString()}');
        emit(newsGetScienceErrorStates(error));
      });
    }
    else {
      emit(networkNotConnectStates(massage: "No Internet !"));
    }
  }


  List<dynamic> matches = [];

  //https://apiv3.apifootball.com/?action=get_events&from=2022-12-03&to=2022-12-03&APIkey=e083da8bdd49b6e2cb8eebb4589e407c78e6f36f79f5bac0f00bdd6fee60e426
  void getMatches() {
    if(matches.length == 0){
      emit(newsMatchesLoadingStates());
      MatchHelper.getMatches(
        url: 'https://apiv3.apifootball.com/?action=get_events&from=${time.year}/${time.month}/${time.day}&to=${time.year}/${time.month}/${time.day}&APIkey=56399d83e0a5a04f9fc2c9f614841bece3aaf2eee5b470b9412053bf0057a327',
      ).then((value) {
        if(value.data == []) {
          emit(newsGetMatchesSuccessStates());
        }else{
          matches = value.data;
          emit(newsGetMatchesSuccessStates());
        }
      }).catchError((error) {
        print('Sports Error is : ${error.toString()}');
        emit(newsGetMatchesSuccessStates());
      });
    } else {
      emit(newsGetMatchesSuccessStates());
    }

  }

  void changeMatches(String date){
    matches.clear();
    emit(newsMatchesLoadingStates());
      MatchHelper.getMatches(
        url: 'https://apiv3.apifootball.com/?action=get_events&from=$date&to=$date&APIkey=56399d83e0a5a04f9fc2c9f614841bece3aaf2eee5b470b9412053bf0057a327',
      ).then((value) {
        matches = value.data;
        emit(newsGetMatchesSuccessStates());
      }).catchError((error) {
        print('Sports Error is : ${error.toString()}');
        emit(newsGetMatchesSuccessStates());
      });
  }
  var selectDate = DateFormat.yMd().format(time);

  bool isDark = true;

void changeMode({bool? fromShared}) {
  if(fromShared != null)
    {
      isDark = fromShared;
      emit(newsChangeModeStates());
    }
  else
    {
      isDark = !isDark;
      cacheHelper.putData(key: "isDark", value: isDark).then((value) {
      });
      if(currentIndex == 0)
        getBusniss();
      if(currentIndex == 1)
        getSports();
      if(currentIndex == 2)
        getScience();
      emit(newsChangeModeStates());
    }

}


}

