class HomeMatchModel {
  String? get;
  Parameters? parameters;
  int? results;
  Paging? paging;
  List<HomeResponse>? response;

  HomeMatchModel.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    results = json['results'];
    paging =
    json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <HomeResponse>[];
      json['response'].forEach((v) {
        response!.add(HomeResponse.fromJson(v));
      });
    }
  }
}

class Parameters {
  String? date;

  Parameters.fromJson(Map<String, dynamic> json) {
    date = json['date'];
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

class HomeResponse {
  Fixture? fixture;
  League? league;
  Teams? teams;
  Goals? goals;
  Score? score;


  HomeResponse.fromJson(Map<String, dynamic> json) {
    fixture =
    json['fixture'] != null ? Fixture.fromJson(json['fixture']) : null;
    league =
    json['league'] != null ? League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
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

class Home {
  int? id;
  String? name;
  String? logo;
  bool? winner;

  Home({this.id, this.name, this.logo, this.winner});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }

}

class Goals {
  int? home;
  int? away;

  Goals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

}

class Score {
  Goals? halftime;
  Goals? fulltime;
  Goals? extratime;
  Goals? penalty;


  Score.fromJson(Map<String, dynamic> json) {
    halftime =
    json['halftime'] != null ? Goals.fromJson(json['halftime']) : null;
    fulltime =
    json['fulltime'] != null ? Goals.fromJson(json['fulltime']) : null;
    extratime = json['extratime'] != null
        ? Goals.fromJson(json['extratime'])
        : null;
    penalty =
    json['penalty'] != null ? Goals.fromJson(json['penalty']) : null;
  }
}
