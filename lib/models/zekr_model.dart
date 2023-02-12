class Zekr {
  String? category;
  int? count;
  String? description;
  String? reference;
  String? zekr;

  Zekr(
      {this.category, this.count, this.description, this.reference, this.zekr});

  Zekr.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['count'] = this.count;
    data['description'] = this.description;
    data['reference'] = this.reference;
    data['zekr'] = this.zekr;
    return data;
  }
}