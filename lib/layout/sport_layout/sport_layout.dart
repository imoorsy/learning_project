import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/home_match_model.dart';
import 'package:todoapp/modules/sport_app/match_page/match_page.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/componants/constants.dart';

class SportLayout extends StatelessWidget {
  SportLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SportCubit cubit = SportCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.green[700]),
            leading: Row(
              children: [
                IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.dark_mode,
                      color: Colors.black87,
                      size: 35,
                    )),
              ],
            ),
            toolbarHeight: 70,
            leadingWidth: 100,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 45,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Moccer',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 35,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
            bottom: Tab(
                height: 65,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.white54,
                            blurRadius: 10,
                            spreadRadius: 3)
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              cubit.getMatchCenter(date: editDateFormat(DateTime.parse(cubit.selectedDate).subtract(const Duration(days: 1)).toString().split(' ')[0]));
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            )),
                        Container(
                          height: double.infinity,
                          width: 5,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.white54,
                                blurRadius: 10,
                                spreadRadius: 3)
                          ]),
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.parse('2010-01-01'),
                                    lastDate: DateTime.parse('2024-01-01'))
                                .then((value) {
                              cubit.getMatchCenter(date: editDateFormatSlash(
                                  DateFormat.yMd().format(value!)));
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.grey[300],
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                cubit.selectedDate,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300]),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 5,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.white54,
                                blurRadius: 10,
                                spreadRadius: 3)
                          ]),
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.getMatchCenter(date: editDateFormat(DateTime.parse(cubit.selectedDate).add(const Duration(days: 1)).toString().split(' ')[0]));
                              },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            )),
                      ],
                    ),
                  ],
                )),
          ),
          drawerScrimColor: Colors.green[700]!.withOpacity(0.3),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sports_soccer,
                      size: 45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Moccer',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                InkWell(
                  highlightColor: Colors.green[300]!.withOpacity(0.5),
                  child: ListTile(
                    iconColor: Colors.green[900],
                    leading: Icon(Icons.sports_soccer,size: 30,),
                    title: Text('League Info',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  onTap: (){
                    print('League Info');
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  highlightColor: Colors.green[300]!.withOpacity(0.5),
                  child: ListTile(
                    iconColor: Colors.green[900],
                    leading: Icon(Icons.text_snippet,size: 30,),
                    title: Text('Team Info',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  onTap: (){
                    print('Team Info');
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  highlightColor: Colors.green[300]!.withOpacity(0.5),
                  child: ListTile(
                    iconColor: Colors.green[900],
                    leading: Icon(Icons.headset_mic,size: 30,),
                    title: Text('Contact US',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  onTap: (){
                    print('Contact US');
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  highlightColor: Colors.green[300]!.withOpacity(0.5),
                  child: ListTile(
                    iconColor: Colors.green[900],
                    leading: Icon(Icons.settings,size: 30,),
                    title: Text('Settings',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  onTap: (){
                    print('Settings');
                  },
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          body: BuildCondition(
            condition: cubit.homeMatchModel == null &&
                state is! GetErrorHomeDataSportState,
            builder: (context) => SingleChildScrollView(
              child: Center(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 90,
                                color: Colors.grey[300]!.withOpacity(0.7),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                      separatorBuilder: (context, index) {
                        return Center();
                      },
                      itemCount: 15)),
            ),
            fallback: (context) => BuildCondition(
              condition: cubit.homeMatchModel == null &&
                  state is GetErrorHomeDataSportState,
              builder: (context) => Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mood_bad,
                    size: 200,
                    color: Colors.green[700],
                  ),
                  Text(
                    'Somthing Went Wrong',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    splashColor: Colors.green[700],
                    onTap: () {
                      cubit.getMatchCenter(date: editDateFormat(todayDate));
                    },
                    child: Container(
                        color: Colors.grey.withOpacity(0.5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'try again',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black),
                        )),
                  ),
                ],
              )),
              fallback: (context) => RefreshIndicator(
                onRefresh: cubit.getMatchCenter,
                displacement: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (cubit.worldCupMatches.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.worldCupMatches, 'World Cup'),
                      if (cubit.WorldCupQualificationEurope.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.WorldCupQualificationEurope,
                            'World Cup Qualification - Europe'),
                      if (cubit.WorldCupQualificationAfrica.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.WorldCupQualificationAfrica,
                            'World Cup Qualification - Africa'),
                      if (cubit.WorldCupQualificationAsia.isNotEmpty)
                        buildLeagueSectionHome(cubit, cubit.worldCupMatches,
                            'World Cup Qualification - Asia'),
                      if (cubit.WorldCupQualificationSouthAmerica.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.WorldCupQualificationSouthAmerica,
                            'World Cup Qualification - South America'),
                      if (cubit.WorldCupQualificationCONCACAF.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.WorldCupQualificationCONCACAF,
                            'World Cup Qualification - CONCACAF'),
                      if (cubit.WorldCupQualificationOceania.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.WorldCupQualificationOceania,
                            'World Cup Qualification - Oceania'),
                      if (cubit.EuroMatches.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.EuroMatches, 'Euro Cup'),
                      if (cubit.EuroChampionshipQualification.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.EuroChampionshipQualification, 'Euro Championship Qualification'),
                      if (cubit.AfricaCupofNations.isNotEmpty)
                        buildLeagueSectionHome(cubit, cubit.AfricaCupofNations,
                            'Africa Cup of Nations'),
                      if (cubit.AfricaCupofNationsQualification.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.AfricaCupofNationsQualification,
                            'Africa Cup of Nations - Qualification'),
                      if (cubit.FIFAClubWorldCupMatches.isNotEmpty)
                        buildLeagueSectionHome(cubit,
                            cubit.FIFAClubWorldCupMatches, 'FIFA World Club Cup'),
                      if (cubit.UCLMatches.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.UCLMatches, 'UEFA Champions League'),
                      if (cubit.UEFAEuropaLeagueMatches.isNotEmpty)
                        buildLeagueSectionHome(cubit,
                            cubit.UEFAEuropaLeagueMatches, 'UEFA Europa League'),
                      if (cubit.UEFAEuropaConferenceLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.UEFAEuropaConferenceLeague,
                            'UEFA Europa Conference League'),
                      if (cubit.UEFASuperCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.UEFASuperCup, 'UEFA Super Cup'),
                      if (cubit.EnglandLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.EnglandLeague, 'England Premier League'),
                      if (cubit.EnglandFACup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.EnglandFACup, 'England FA Cup'),
                      if (cubit.EnglandEFLCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.EnglandEFLCup, 'England EFL Cup'),
                      if (cubit.ItalianLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.ItalianLeague, 'Serie A'),
                      if (cubit.ItalianCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.ItalianCup, 'Italian Cup'),
                      if (cubit.SpanishLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.SpanishLeague, 'LaLiga'),
                      if (cubit.SpanishCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.SpanishCup, 'Spanish Cup'),
                      if (cubit.GermanLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.GermanLeague, 'Bundesliga'),
                      if (cubit.GermanDFBPokalCup.isNotEmpty)
                        buildLeagueSectionHome(cubit, cubit.GermanDFBPokalCup,
                            'German DFB Pokal Cup'),
                      if (cubit.FranceLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.FranceLeague, 'France Premier League'),
                      if (cubit.FranceCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.FranceCup, 'France Cup'),
                      if (cubit.CAFChampionsLeagueMatches.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.CAFChampionsLeagueMatches,
                            'CAF Champions League'),
                      if (cubit.CAFConfederationCupMatches.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.CAFConfederationCupMatches,
                            'CAF Confederation Cup'),
                      if (cubit.AFCChampionsLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.AFCChampionsLeague, 'Saudi Pro League'),
                      if (cubit.EgyptionLeague.isNotEmpty)
                        buildLeagueSectionHome(cubit, cubit.EgyptionLeague,
                            'Egyptian Premier League'),
                      if (cubit.SaudiLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.SaudiLeague, 'Saudi Pro League'),
                      if (cubit.QatarStarsLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.QatarStarsLeague, 'Qatar Stars League'),
                      if (cubit.QatarQSLCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.QatarQSLCup, 'Qatar QSL Cup'),
                      if (cubit.QatarEmirCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.QatarEmirCup, 'Qatar Emir Cup'),
                      if (cubit.QatarQatarCup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.QatarQatarCup, 'Qatar Cup'),
                      if (cubit.QatarQFACup.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.QatarQFACup, 'Qatar QFA Cup'),
                      if (cubit.AfricanNationsChampionship.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.AfricanNationsChampionship,
                            'African Nations Championship'),
                      if (cubit.England2League.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.England2League, 'England ChampionShip'),
                      if (cubit.France2League.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.France2League, 'France Second League'),
                      if (cubit.CONCACAFChampionsLeague.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit,
                            cubit.CONCACAFChampionsLeague,
                            'CONCACAF Champions League'),
                      if (cubit.Saudi2League.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.Saudi2League, 'Saudi Second League'),
                      if (cubit.FriendliesMatch.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.FriendliesMatch, 'Friendlies Match'),
                      if (cubit.FriendliesClubMatch.isNotEmpty)
                        buildLeagueSectionHome(
                            cubit, cubit.FriendliesClubMatch, 'Friendlies Club Match'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMatchHomeItem(context, HomeResponse model) => InkWell(
        splashColor: Colors.green[700],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchScreen()));
          SportCubit.get(context).getMatch(model.fixture!.id!);
          print(model.fixture!.id!);
        },
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300]!.withOpacity(0.5),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.teams!.home!.logo!,
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    model.teams!.home!.name!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: BuildCondition(
                condition: model.fixture!.status!.short == '1H' ||
                    model.fixture!.status!.short == '2H' ||
                    model.fixture!.status!.short == 'ET',
                builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.goals!.home == null
                          ? '0'
                          : model.goals!.home.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 3,
                        ),
                        Text(
                          '${model.fixture!.status!.elapsed}\'',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                        model.goals!.away == null
                            ? '0'
                            : model.goals!.away.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                fallback: (context) => BuildCondition(
                  condition: model.fixture!.status!.short == 'FT',
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        child: const Text(
                          'FT',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${model.goals!.home} : ${model.goals!.away}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  fallback: (context) => BuildCondition(
                    condition: model.fixture!.status!.short == 'NS',
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          editMatchTime(
                              DateTime.parse(model.fixture!.date!).hour,
                              DateTime.parse(model.fixture!.date!).minute),
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    fallback: (context) => BuildCondition(
                      condition: model.fixture!.status!.short == 'HT',
                      builder: (context) => Column(
                        children: [
                          Container(
                            color: Colors.green[700],
                            child: const Text(
                              'HT',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                model.goals!.home == null
                                    ? '0'
                                    : model.goals!.home.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    value: 1,
                                    strokeWidth: 3,
                                  ),
                                  Text(
                                    '${model.fixture!.status!.elapsed}\'',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                model.goals!.away == null
                                    ? '0'
                                    : model.goals!.away.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                      fallback: (context) => BuildCondition(
                        condition: model.fixture!.status!.short == 'BT',
                        builder: (context) => Column(
                          children: [
                            const Text(
                              'ET Break',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            Row(
                              children: [
                                Text(
                                  model.goals!.home == null
                                      ? '0'
                                      : model.goals!.home.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: model.teams!.home!.winner!
                                          ? Colors.green
                                          : Colors.redAccent),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      value: 1,
                                      strokeWidth: 3,
                                    ),
                                    Text(
                                      '${model.fixture!.status!.elapsed}\'',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  model.goals!.away == null
                                      ? '0'
                                      : model.goals!.away.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: model.teams!.away!.winner!
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        fallback: (context) => BuildCondition(
                          condition: model.fixture!.status!.short == 'PST',
                          builder: (context) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text(
                                    'مؤجل',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => const Center(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.teams!.away!.logo!,
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    model.teams!.away!.name!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );

  Widget buildLeagueSectionHome(SportCubit cubit,
          List<HomeResponse> matchesList, String leagueName) =>
      Column(
        children: [
          InkWell(
            splashColor: Colors.grey[500],
            onTap: () {
              print('tab');
            },
            child: Container(
              width: double.infinity,
              color: Colors.grey[500]!.withOpacity(0.7),
              height: 40,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      imageUrl: matchesList.first.league!.logo!,
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      leagueName,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  buildMatchHomeItem(context, matchesList[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount: matchesList.length),
        ],
      );
}
