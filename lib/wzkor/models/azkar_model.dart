class AzkarModel {
  String? category;
  int? count;
  String? description;
  String? reference;
  String? zekr;

  AzkarModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
  }
}
