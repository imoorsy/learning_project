class AsmaaAllahModel {
  String? name;
  String? text;

  AsmaaAllahModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
  }
}