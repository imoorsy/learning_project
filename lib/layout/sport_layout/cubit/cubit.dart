import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/head_to_head_model.dart';
import 'package:todoapp/models/home_match_model.dart';
import 'package:todoapp/models/league_position_model.dart';
import 'package:todoapp/models/player_model.dart';
import 'package:todoapp/models/single_match_model.dart';
import 'package:todoapp/shared/componants/constants.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';

class SportCubit extends Cubit<SportStates> {
  SportCubit() : super(InitialSportState());

  static SportCubit get(context) => BlocProvider.of(context);

  HomeMatchModel? homeMatchModel;
  List<HomeResponse> worldCupMatches = [],
      WorldCupQualificationEurope = [],
      WorldCupQualificationAfrica = [],
      WorldCupQualificationAsia = [],
      WorldCupQualificationCONCACAF = [],
      WorldCupQualificationOceania = [],
      WorldCupQualificationSouthAmerica = [],
      UCLMatches = [],
      UEFAEuropaLeagueMatches = [],
      UEFAEuropaConferenceLeague = [],
      UEFASuperCup = [],
      EuroMatches = [],
      AfricaCupofNations = [],
      AfricaCupofNationsQualification = [],
      AfricanNationsChampionship = [],
      CAFChampionsLeagueMatches = [],
      CAFConfederationCupMatches = [],
      CAFSuperCup = [],
      CONCACAFChampionsLeague = [],
      FIFAClubWorldCupMatches = [],
      EnglandLeague = [],
      England2League = [],
      EnglandFACup = [],
      EnglandEFLCup = [],
      ItalianLeague = [],
      ItalianCup = [],
      SpanishLeague = [],
      SpanishCup = [],
      FranceLeague = [],
      France2League = [],
      FranceCup = [],
      GermanLeague = [],
      GermanDFBPokalCup = [],
      EnglandSuperCup = [],
      SpanishSuperCup = [],
      ItalianSuperCup = [],
      FranceSuperCup = [],
      GermanSuperCup = [],
      EgyptionLeague = [],
      AFCChampionsLeague = [],
      SaudiLeague = [],
      Saudi2League = [],
      QatarStarsLeague = [],
      QatarQSLCup= [],
      QatarEmirCup = [],
      QatarQatarCup= [],
      QatarQFACup= [],
      EuroChampionshipQualification = [],
      FriendliesMatch = [],
      FriendliesClubMatch = [];

  String selectedDate = editDateFormat(todayDate);

  Future<void> getMatchCenter({String? date}) async {
    emit(GetLoadingHomeDataSportState());
    selectedDate = date ?? selectedDate;
    print(selectedDate);
    homeMatchModel = null;
    DioHelper.getMatchData(url: 'fixtures', query: {
      'date': selectedDate,
    }).then((value) {
      homeMatchModel = HomeMatchModel.fromJson(value.data);
      worldCupMatches = [];
      WorldCupQualificationEurope = [];
      WorldCupQualificationAfrica = [];
      WorldCupQualificationAsia = [];
      WorldCupQualificationCONCACAF = [];
      WorldCupQualificationOceania = [];
      WorldCupQualificationSouthAmerica = [];
      UCLMatches = [];
      UEFAEuropaLeagueMatches = [];
      UEFAEuropaConferenceLeague = [];
      UEFASuperCup = [];
      EuroMatches = [];
      AfricaCupofNations = [];
      AfricaCupofNationsQualification = [];
      AfricanNationsChampionship = [];
      CAFChampionsLeagueMatches = [];
      CAFConfederationCupMatches = [];
      CAFSuperCup = [];
      CONCACAFChampionsLeague = [];
      FIFAClubWorldCupMatches = [];
      EnglandLeague = [];
      England2League = [];
      EnglandFACup = [];
      EnglandEFLCup = [];
      ItalianLeague = [];
      ItalianCup = [];
      SpanishLeague = [];
      SpanishCup = [];
      FranceLeague = [];
      France2League = [];
      FranceCup = [];
      GermanLeague = [];
      GermanDFBPokalCup = [];
      EnglandSuperCup = [];
      SpanishSuperCup = [];
      ItalianSuperCup = [];
      FranceSuperCup = [];
      GermanSuperCup = [];
      EgyptionLeague = [];
      AFCChampionsLeague = [];
      SaudiLeague = [];
      Saudi2League = [];
      EuroChampionshipQualification = [];
      FriendliesMatch = [];
      FriendliesClubMatch = [];
      for (var element in homeMatchModel!.response!) {
        if (element.league!.id == 1) {
          worldCupMatches.add(element);
        } else if (element.league!.id == 2) {
          UCLMatches.add(element);
        } else if (element.league!.id == 3) {
          UEFAEuropaLeagueMatches.add(element);
        } else if (element.league!.id == 4) {
          EuroMatches.add(element);
        } else if (element.league!.id == 6) {
          AfricaCupofNations.add(element);
        } else if (element.league!.id == 10) {
          FriendliesMatch.add(element);
        } else if (element.league!.id == 667) {
          FriendliesClubMatch.add(element);
        } else if (element.league!.id == 12) {
          CAFChampionsLeagueMatches.add(element);
        } else if (element.league!.id == 15) {
          FIFAClubWorldCupMatches.add(element);
        } else if (element.league!.id == 16) {
          CONCACAFChampionsLeague.add(element);
        } else if (element.league!.id == 17) {
          AFCChampionsLeague.add(element);
        } else if (element.league!.id == 19) {
          AfricanNationsChampionship.add(element);
        } else if (element.league!.id == 20) {
          CAFConfederationCupMatches.add(element);
        } else if (element.league!.id == 29) {
          WorldCupQualificationAfrica.add(element);
        } else if (element.league!.id == 30) {
          WorldCupQualificationAsia.add(element);
        } else if (element.league!.id == 31) {
          WorldCupQualificationCONCACAF.add(element);
        } else if (element.league!.id == 32) {
          WorldCupQualificationEurope.add(element);
        } else if (element.league!.id == 33) {
          WorldCupQualificationOceania.add(element);
        } else if (element.league!.id == 34) {
          WorldCupQualificationSouthAmerica.add(element);
        } else if (element.league!.id == 36) {
          AfricaCupofNationsQualification.add(element);
        } else if (element.league!.id == 39) {
          EnglandLeague.add(element);
        } else if (element.league!.id == 40) {
          England2League.add(element);
        } else if (element.league!.id == 45) {
          EnglandFACup.add(element);
        } else if (element.league!.id == 48) {
          EnglandEFLCup.add(element);
        } else if (element.league!.id == 61) {
          FranceLeague.add(element);
        } else if (element.league!.id == 62) {
          France2League.add(element);
        } else if (element.league!.id == 66) {
          FranceCup.add(element);
        } else if (element.league!.id == 78) {
          GermanLeague.add(element);
        } else if (element.league!.id == 81) {
          GermanDFBPokalCup.add(element);
        } else if (element.league!.id == 135) {
          ItalianLeague.add(element);
        } else if (element.league!.id == 137) {
          ItalianCup.add(element);
        } else if (element.league!.id == 848) {
          UEFAEuropaConferenceLeague.add(element);
        } else if (element.league!.id == 531) {
          UEFASuperCup.add(element);
        } else if (element.league!.id == 533) {
          CAFSuperCup.add(element);
        } else if (element.league!.id == 233) {
          EgyptionLeague.add(element);
        } else if (element.league!.id == 140) {
          SpanishLeague.add(element);
        } else if (element.league!.id == 143) {
          SpanishCup.add(element);
        } else if (element.league!.id == 307) {
          SaudiLeague.add(element);
        } else if (element.league!.id == 308) {
          Saudi2League.add(element);
        } else if (element.league!.id == 960) {
          EuroChampionshipQualification.add(element);
        } else if (element.league!.id == 960) {
          EuroChampionshipQualification.add(element);
        }
      }

      emit(GetSuccessHomeDataSportState());
    }).catchError((error) {
      print('ersc : ${error.toString()}');
      emit(GetErrorHomeDataSportState());
    });
  }

  SingleMatchModel? currentMatch;
  LeaguePosition? leaguePosition;
  HeadToHead? headToHead;
  List<int> homeForm = [];
  List<int> awayForm = [];
  Future<void> getMatch(int id) async {
    emit(GetLoadingCrntMatchSportState());
    currentMatch = null;
    await DioHelper.getMatchData(url: 'fixtures', query: {
      'id': id,
    }).then((value) {
      currentMatch = SingleMatchModel.fromJson(value.data);
      homeForm = editStringList(currentMatch!.response!.first.lineups!.first.formation!.split('-'));
      awayForm = editStringList(currentMatch!.response!.first.lineups!.last.formation!.split('-'));
      emit(GetSuccessCrntMatchSportState());
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });

    //League Positions
    leaguePosition = null;
    await DioHelper.getMatchData(url: 'standings', query: {
      'league': currentMatch!.response!.first.league!.id,
      'season' : currentMatch!.response!.first.league!.season,
    }).then((value) {
      leaguePosition = LeaguePosition.fromJson(value.data);
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });
    // HeadToHead Matches
    headToHead = null;
    await DioHelper.getMatchData(url: 'fixtures/headtohead', query: {
      'h2h': '${currentMatch!.response!.first.teams!.home!.id!}-${currentMatch!.response!.first.teams!.away!.id!}',
      'last': 10,
    }).then((value) {
      headToHead = HeadToHead.fromJson(value.data);
      emit(GetSuccessCrntMatchSportState());
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });
  }

  Future<void> getSelctedMatch() async {
    emit(GetLoadingCrntMatchSportState());
    int currentMatchId = currentMatch!.response!.first.fixture!.id!;
    currentMatch = null;
    await DioHelper.getMatchData(url: 'fixtures', query: {
      'id': currentMatchId,
    }).then((value) {
      currentMatch = SingleMatchModel.fromJson(value.data);
      homeForm = editStringList(currentMatch!.response!.first.lineups!.first.formation!.split('-'));
      awayForm = editStringList(currentMatch!.response!.first.lineups!.last.formation!.split('-'));
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });

    //League Positions
    leaguePosition = null;
    await DioHelper.getMatchData(url: 'standings', query: {
      'league': currentMatch!.response!.first.league!.id,
      'season' : currentMatch!.response!.first.league!.season,
    }).then((value) {
      leaguePosition = LeaguePosition.fromJson(value.data);
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });
    // HeadToHead Matches
    headToHead = null;
    await DioHelper.getMatchData(url: 'fixtures/headtohead', query: {
      'h2h': '${currentMatch!.response!.first.teams!.home!.id!}-${currentMatch!.response!.first.teams!.away!.id!}',
      'last': 10,
    }).then((value) {
      headToHead = HeadToHead.fromJson(value.data);
      emit(GetSuccessCrntMatchSportState());
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntMatchSportState());
    });
  }

  PlayerModel? playerModel;
  Future<void> getPlayer(int id,int season) async {
    emit(GetLoadingCrntPlayerSportState());
    playerModel = null;
    await DioHelper.getMatchData(url: 'players', query: {
      'id': id,
      'season' : season,
    }).then((value) {
      playerModel = PlayerModel.fromJson(value.data);
      emit(GetSuccessCrntPlayerSportState());
    }).catchError((error) {
      print('curntMatch : ${error.toString()}');
      emit(GetErrorCrntPlayerSportState());
    });
  }
}
