class SingleMatchModel {
  String? get;
  int? results;
  Paging? paging;
  List<Response>? response;

  SingleMatchModel.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    results = json['results'];
    paging =
        json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }
}

class Paging {
  int? current;
  int? total;

  Paging.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    total = json['total'];
  }
}

class Response {
  Fixture? fixture;
  League? league;
  Teams? teams;
  MatchGoals? goals;
  Score? score;
  List<Events>? events;
  List<Lineups>? lineups;
  List<ResponseStatistics>? statistics;
  List<Players>? players;

  Response.fromJson(Map<String, dynamic> json) {
    fixture =
        json['fixture'] != null ? Fixture.fromJson(json['fixture']) : null;
    league =
        json['league'] != null ? League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
    goals = json['goals'] != null ? MatchGoals.fromJson(json['goals']) : null;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
    if (json['lineups'] != null) {
      lineups = <Lineups>[];
      json['lineups'].forEach((v) {
        lineups!.add(Lineups.fromJson(v));
      });
    }
    if (json['statistics'] != null) {
      statistics = <ResponseStatistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(ResponseStatistics.fromJson(v));
      });
    }
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
  }
}

class Fixture {
  int? id;
  String? referee;
  String? timezone;
  String? date;
  int? timestamp;
  Periods? periods;
  Venue? venue;
  Status? status;

  Fixture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referee = json['referee'];
    timezone = json['timezone'];
    date = json['date'];
    timestamp = json['timestamp'];
    periods =
    json['periods'] != null ? Periods.fromJson(json['periods']) : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
  }
}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  String? round;

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
    round = json['round'];
  }
}

class Teams {
  Home? home;
  Home? away;

  Teams.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
  }
}

class MatchGoals {
  int? home;
  int? away;

  MatchGoals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }
}

class Score {
  MatchGoals? halftime;
  MatchGoals? fulltime;
  Extratime? extratime;
  Extratime? penalty;

  Score.fromJson(Map<String, dynamic> json) {
    halftime =
    json['halftime'] != null ? MatchGoals.fromJson(json['halftime']) : null;
    fulltime =
    json['fulltime'] != null ? MatchGoals.fromJson(json['fulltime']) : null;
    extratime = json['extratime'] != null
        ? Extratime.fromJson(json['extratime'])
        : null;
    penalty = json['penalty'] != null
        ? Extratime.fromJson(json['penalty'])
        : null;
  }
}

class Events {
  Time? time;
  EventTeam? team;
  EventPlayer? player;
  EventPlayer? assist;
  String? type;
  String? detail;
  String? comments;

  Events.fromJson(Map<String, dynamic> json) {
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    team = json['team'] != null ? EventTeam.fromJson(json['team']) : null;
    player = json['player'] != null ? EventPlayer.fromJson(json['player']) : null;
    assist =
    json['assist'] != null ? EventPlayer.fromJson(json['assist']) : null;
    type = json['type'];
    detail = json['detail'];
    comments = json['comments'];
  }
}

class Lineups {
  Team? team;
  String? formation;
  List<StartXI>? startXI;
  List<SubXI>? substitutes;
  Coach? coach;

  Lineups.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    formation = json['formation'];
    if (json['startXI'] != null) {
      startXI = <StartXI>[];
      json['startXI'].forEach((v) {
        startXI!.add(StartXI.fromJson(v));
      });
    }
    if (json['substitutes'] != null) {
      substitutes = <SubXI>[];
      json['substitutes'].forEach((v) {
        substitutes!.add(SubXI.fromJson(v));
      });
    }
    coach = json['coach'] != null ? Coach.fromJson(json['coach']) : null;
  }
}

class ResponseStatistics {
  Team? team;
  List<Statistics>? statistics;

  ResponseStatistics.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(Statistics.fromJson(v));
      });
    }
  }
}

class Periods {
  int? first;
  int? second;

  Periods.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
  }
}

class Venue {
  int? id;
  String? name;
  String? city;

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
  }
}

class Status {
  String? long;
  String? short;
  int? elapsed;

  Status.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    short = json['short'];
    elapsed = json['elapsed'];
  }
}

class Home {
  int? id;
  String? name;
  String? logo;
  bool? winner;

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }
}

class Extratime {
  Null? home;
  Null? away;

  Extratime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }
}

class Time {
  int? elapsed;
  int? extra;

  Time.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    extra = json['extra'];
  }
}

class EventTeam {
  int? id;
  String? name;
  String? logo;

  EventTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }
}

class EventPlayer {
  int? id;
  String? name;

  EventPlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Team {
  int? id;
  String? name;
  String? logo;
  TeamColors? colors;

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    colors =
        json['colors'] != null ? TeamColors.fromJson(json['colors']) : null;
  }
}

class TeamColors {
  Player? player;
  Player? goalkeeper;

  TeamColors.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    goalkeeper = json['goalkeeper'] != null
        ? Player.fromJson(json['goalkeeper'])
        : null;
  }
}

class Player {
  String? primary;
  String? number;
  String? border;

  Player.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    number = json['number'];
    border = json['border'];
  }
}

class StartXI {
  LineupPlayer? player;

  StartXI.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? LineupPlayer.fromJson(json['player']) : null;
  }
}

class LineupPlayer {
  int? id;
  String? name;
  int? number;
  String? pos;
  String? grid;

  LineupPlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    pos = json['pos'];
    grid = json['grid'];
  }
}

class SubXI {
  LineupSubPlayer? player;

  SubXI.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? LineupSubPlayer.fromJson(json['player']) : null;
  }
}

class LineupSubPlayer {
  int? id;
  String? name;
  int? number;
  String? pos;

  LineupSubPlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    pos = json['pos'];
  }
}

class Coach {
  int? id;
  String? name;
  String? photo;

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
}

class Statistics {
  String? type;
  dynamic value;

  Statistics.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }
}

class Players {
  UpdateTeam? team;
  List<StaticPlayers>? players;

  Players.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? UpdateTeam.fromJson(json['team']) : null;
    if (json['players'] != null) {
      players = <StaticPlayers>[];
      json['players'].forEach((v) {
        players!.add(StaticPlayers.fromJson(v));
      });
    }
  }
}

class UpdateTeam {
  int? id;
  String? name;
  String? logo;
  String? update;

  UpdateTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    update = json['update'];
  }
}

class StaticPlayers {
  Coach? player;
  List<AllPlayerStatistics>? statistics;

  StaticPlayers.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Coach.fromJson(json['player']) : null;
    if (json['statistics'] != null) {
      statistics = <AllPlayerStatistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(AllPlayerStatistics.fromJson(v));
      });
    }
  }
}

class AllPlayerStatistics {
  Games? games;
  dynamic offsides;
  Shots? shots;
  Goals? goals;
  Passes? passes;
  Tackles? tackles;
  Duels? duels;
  Dribbles? dribbles;
  Fouls? fouls;
  Cards? cards;
  Extratime? penalty;

  AllPlayerStatistics.fromJson(Map<String, dynamic> json) {
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
    offsides = json['offsides'];
    shots = json['shots'] != null ? Shots.fromJson(json['shots']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    passes =
        json['passes'] != null ? Passes.fromJson(json['passes']) : null;
    tackles =
        json['tackles'] != null ? Tackles.fromJson(json['tackles']) : null;
    duels = json['duels'] != null ? Duels.fromJson(json['duels']) : null;
    dribbles = json['dribbles'] != null
        ? Dribbles.fromJson(json['dribbles'])
        : null;
    fouls = json['fouls'] != null ? Fouls.fromJson(json['fouls']) : null;
    cards = json['cards'] != null ? Cards.fromJson(json['cards']) : null;
    penalty = json['penalty'] != null
        ? Extratime.fromJson(json['penalty'])
        : null;
  }
}

class Games {
  int? minutes;
  int? number;
  String? position;
  String? rating;
  bool? captain;
  bool? substitute;

  Games.fromJson(Map<String, dynamic> json) {
    minutes = json['minutes'];
    number = json['number'];
    position = json['position'];
    rating = json['rating'];
    captain = json['captain'];
    substitute = json['substitute'];
  }
}

class Shots {
  int? total;
  int? on;

  Shots.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    on = json['on'];
  }
}

class Goals {
  int? total;
  int? conceded;
  int? assists;
  int? saves;

  Goals.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    conceded = json['conceded'];
    assists = json['assists'];
    saves = json['saves'];
  }
}

class Passes {
  int? total;
  int? key;
  String? accuracy;

  Passes.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    key = json['key'];
    accuracy = json['accuracy'];
  }
}

class Tackles {
  int? total;
  int? blocks;
  int? interceptions;

  Tackles.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    blocks = json['blocks'];
    interceptions = json['interceptions'];
  }
}

class Duels {
  int? total;
  int? won;

  Duels.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    won = json['won'];
  }
}

class Dribbles {
  int? attempts;
  int? success;
  int? past;

  Dribbles.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    success = json['success'];
    past = json['past'];
  }
}

class Fouls {
  int? drawn;
  int? committed;

  Fouls.fromJson(Map<String, dynamic> json) {
    drawn = json['drawn'];
    committed = json['committed'];
  }
}

class Cards {
  int? yellow;
  int? red;

  Cards.fromJson(Map<String, dynamic> json) {
    yellow = json['yellow'];
    red = json['red'];
  }
}

class Penalty {
  bool? won;
  bool? commited;
  int? scored;
  int? missed;
  int? saved;

  Penalty.fromJson(Map<String, dynamic> json) {
    won = json['won'];
    commited = json['commited'];
    scored = json['scored'];
    missed = json['missed'];
    saved = json['saved'];
  }
}
