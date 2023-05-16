class HeadToHead {
  String? get;
  Parameters? parameters;
  int? results;
  Paging? paging;
  List<Response>? response;


  HeadToHead.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    results = json['results'];
    paging =
    json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

}

class Parameters {
  String? h2h;
  String? last;


  Parameters.fromJson(Map<String, dynamic> json) {
    h2h = json['h2h'];
    last = json['last'];
  }

}

class Paging {
  int? current;
  int? total;


  Paging.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['total'] = this.total;
    return data;
  }
}

class Response {
  Fixture? fixture;
  League? league;
  Teams? teams;
  Goals? goals;
  Score? score;


  Response.fromJson(Map<String, dynamic> json) {
    fixture =
    json['fixture'] != null ? new Fixture.fromJson(json['fixture']) : null;
    league =
    json['league'] != null ? new League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
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
    json['periods'] != null ? new Periods.fromJson(json['periods']) : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
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
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
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
  Extratime? extratime;
  Extratime? penalty;


  Score.fromJson(Map<String, dynamic> json) {
    halftime =
    json['halftime'] != null ? new Goals.fromJson(json['halftime']) : null;
    fulltime =
    json['fulltime'] != null ? new Goals.fromJson(json['fulltime']) : null;
    extratime = json['extratime'] != null
        ? new Extratime.fromJson(json['extratime'])
        : null;
    penalty = json['penalty'] != null
        ? new Extratime.fromJson(json['penalty'])
        : null;
  }

}

class Extratime {
  int? home;
  int? away;


  Extratime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

}
