class LeaguePosition {
  String? get;
  Parameters? parameters;
  int? results;
  Paging? paging;
  List<Response>? response;

  LeaguePosition.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null ? Parameters.fromJson(json['parameters']) : null;
    results = json['results'];
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) { response!.add(Response.fromJson(v)); });
    }
  }
}

class Parameters {
  String? league;
  String? season;


  Parameters.fromJson(Map<String, dynamic> json) {
    league = json['league'];
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
  League? league;


  Response.fromJson(Map<String, dynamic> json) {
    league = json['league'] != null ? League.fromJson(json['league']) : null;
  }

}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  List<Postion>? standings;

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
    if (json['standings'] != null) {
      standings = <Postion>[];
      json['standings'].forEach((v) {
        for(int i = 0; i < json['standings'][0].length;i++) {
          standings!.add(Postion.fromJson(v[i]));
        }
      });
    }
  }

}



class Postion {
  int? rank;
  Team? team;
  int? points;
  int? goalsDiff;
  String? group;
  String? form;
  String? status;
  String? description;
  All? all;
  All? home;
  All? away;
  String? update;


  Postion.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    points = json['points'];
    goalsDiff = json['goalsDiff'];
    group = json['group'];
    form = json['form'];
    status = json['status'];
    description = json['description'];
    all = json['all'] != null ? All.fromJson(json['all']) : null;
    home = json['home'] != null ? All.fromJson(json['home']) : null;
    away = json['away'] != null ? All.fromJson(json['away']) : null;
    update = json['update'];
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

class All {
  int? played;
  int? win;
  int? draw;
  int? lose;
  Goals? goals;


  All.fromJson(Map<String, dynamic> json) {
    played = json['played'];
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
  }

}

class Goals {
  int? forIt;
  int? againstIt;


  Goals.fromJson(Map<String, dynamic> json) {
    forIt = json['for'];
    againstIt = json['against'];
  }

}


