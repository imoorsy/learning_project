class PlayerModel {
  String? get;
  Parameters? parameters;
  int? results;
  Paging? paging;
  List<Response>? response;


  PlayerModel.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null ? new Parameters.fromJson(json['parameters']) : null;
    results = json['results'];
    paging = json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) { response!.add(new Response.fromJson(v)); });
    }
  }

}

class Parameters {
  String? id;
  String? season;


  Parameters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    season = json['season'];
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
  Player? player;
  List<Statistics>? statistics;


  Response.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? new Player.fromJson(json['player']) : null;
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) { statistics!.add(new Statistics.fromJson(v)); });
    }
  }

}

class Player {
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  int? age;
  Birth? birth;
  String? nationality;
  String? height;
  String? weight;
  bool? injured;
  String? photo;


  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    birth = json['birth'] != null ? new Birth.fromJson(json['birth']) : null;
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    injured = json['injured'];
    photo = json['photo'];
  }

}

class Birth {
  String? date;
  String? place;
  String? country;


  Birth.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    place = json['place'];
    country = json['country'];
  }

}

class Statistics {
  Team? team;
  League? league;
  Games? games;
  Substitutes? substitutes;
  Shots? shots;
  Goals? goals;
  Passes? passes;
  Tackles? tackles;
  Duels? duels;
  Dribbles? dribbles;
  Fouls? fouls;
  Cards? cards;
  Penalty? penalty;


  Statistics.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    league = json['league'] != null ? new League.fromJson(json['league']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
    substitutes = json['substitutes'] != null ? new Substitutes.fromJson(json['substitutes']) : null;
    shots = json['shots'] != null ? new Shots.fromJson(json['shots']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    passes = json['passes'] != null ? new Passes.fromJson(json['passes']) : null;
    tackles = json['tackles'] != null ? new Tackles.fromJson(json['tackles']) : null;
    duels = json['duels'] != null ? new Duels.fromJson(json['duels']) : null;
    dribbles = json['dribbles'] != null ? new Dribbles.fromJson(json['dribbles']) : null;
    fouls = json['fouls'] != null ? new Fouls.fromJson(json['fouls']) : null;
    cards = json['cards'] != null ? new Cards.fromJson(json['cards']) : null;
    penalty = json['penalty'] != null ? new Penalty.fromJson(json['penalty']) : null;
  }

}

class Team {
  int? id;
  String? name;
  String? logo;


  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;


  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
  }

}

class Games {
  int? appearences;
  int? lineups;
  int? minutes;
  int? number;
  String? position;
  String? rating;
  bool? captain;


  Games.fromJson(Map<String, dynamic> json) {
    appearences = json['appearences'];
    lineups = json['lineups'];
    minutes = json['minutes'];
    number = json['number'];
    position = json['position'];
    rating = json['rating'];
    captain = json['captain'];
  }

}

class Substitutes {
  int? subin;
  int? subout;
  int? bench;


  Substitutes.fromJson(Map<String, dynamic> json) {
    subin = json['in'];
    subout = json['out'];
    bench = json['bench'];
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
  int? accuracy;


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
  int? yellowred;
  int? red;


  Cards.fromJson(Map<String, dynamic> json) {
    yellow = json['yellow'];
    yellowred = json['yellowred'];
    red = json['red'];
  }

}

class Penalty {
  int? won;
  int? commited;
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
