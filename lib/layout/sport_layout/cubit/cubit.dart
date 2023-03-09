import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/home_match_model.dart';
import 'package:todoapp/models/single_match_model.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';

class SportCubit extends Cubit<SportStates> {
  SportCubit() : super(InitialSportState());

  static SportCubit get(context) => BlocProvider.of(context);


  HomeMatchModel? homeMatchModel;
  List<HomeResponse> worldCupMatches = [];
  List<HomeResponse> UCLMatches = [];
  List<HomeResponse> UEFAEuropaLeagueMatches = [];
  List<HomeResponse> EuroMatches = [];
  List<HomeResponse> CAFChampionsLeagueMatches = [];
  List<HomeResponse> FIFAClubWorldCupMatches = [];
  List<HomeResponse> EnglandLeague = [];
  List<HomeResponse> England2League = [];
  List<HomeResponse> EnglandFACup = [];
  List<HomeResponse> EnglandEFLCup = [];
  List<HomeResponse> ItalianLeague = [];
  List<HomeResponse> ItalianCup = [];
  List<HomeResponse> SpanishLeague = [];
  List<HomeResponse> SpanishCup = [];
  List<HomeResponse> FranceLeague = [];
  List<HomeResponse> France2League = [];
  List<HomeResponse> FranceCup = [];
  List<HomeResponse> GermanLeague = [];
  List<HomeResponse> GermanDFBPokalCup = [];
  List<HomeResponse> EgyptionLeague = [];
  List<HomeResponse> SaudiLeague = [];
  List<HomeResponse> Saudi2League = [];

  Future<void> getMatchCenter() async {
    emit(GetLoadingHomeDataSportState());
    await DioHelper.getMatchData(url: 'fixtures', query: {
      'date' : '2023-03-07',
    }).then((value) {
      homeMatchModel = HomeMatchModel.fromJson(value.data);
      worldCupMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 1) {
          return true;
        }
        return false;
      }).toList();
      UCLMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 2) {
          return true;
        }
        return false;
      }).toList();
      UEFAEuropaLeagueMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 3) {
          return true;
        }
        return false;
      }).toList();
      EuroMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 4) {
          return true;
        }
        return false;
      }).toList();
      FIFAClubWorldCupMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 15) {
          return true;
        }
        return false;
      }).toList();
      CAFChampionsLeagueMatches = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 12) {
          return true;
        }
        return false;
      }).toList();
      EgyptionLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 233) {
          return true;
        }
        return false;
      }).toList();
      EnglandLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 39) {
          return true;
        }
        return false;
      }).toList();
      England2League = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 40) {
          return true;
        }
        return false;
      }).toList();
      EnglandFACup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 45) {
          return true;
        }
        return false;
      }).toList();
      EnglandEFLCup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 48) {
          return true;
        }
        return false;
      }).toList();
      FranceLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 61) {
          return true;
        }
        return false;
      }).toList();
      France2League = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 62) {
          return true;
        }
        return false;
      }).toList();
      FranceCup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 66) {
          return true;
        }
        return false;
      }).toList();
      GermanLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 78) {
          return true;
        }
        return false;
      }).toList();
      GermanDFBPokalCup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 81) {
          return true;
        }
        return false;
      }).toList();
      ItalianLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 135) {
          return true;
        }
        return false;
      }).toList();
      ItalianCup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 137) {
          return true;
        }
        return false;
      }).toList();
      SpanishLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 140) {
          return true;
        }
        return false;
      }).toList();
      SpanishCup = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 143) {
          return true;
        }
        return false;
      }).toList();
      EgyptionLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 233) {
          return true;
        }
        return false;
      }).toList();
      SaudiLeague = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 307) {
          return true;
        }
        return false;
      }).toList();
      Saudi2League = homeMatchModel!.response!.where((element) {
        if(element.league!.id == 308) {
          return true;
        }
        return false;
      }).toList();
      emit(GetSuccessHomeDataSportState());
    }).catchError((error){
      print('ersc : ${error.toString()}');
      emit(GetErrorHomeDataSportState());
    });
  }


  SingleMatchModel? currentMatch;

  Future<void> getMatch(int id) async {
    emit(GetLoadingCrntMatchSportState());
    currentMatch = null;
    await DioHelper.getMatchData(url: 'fixtures', query: {
      'id' : id,
    }).then((value) {
      currentMatch = SingleMatchModel.fromJson(value.data);
      print(currentMatch!.response!.first.lineups!.first.coach!.name);
      emit(GetSuccessCrntMatchSportState());
    }).catchError((error){
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });
  }
}