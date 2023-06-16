class ChequeNotif {
  int? id;
  String? title;
  String? message;
  String? date;
  String? chequeNum;

  ChequeNotif({
    this.id,
    this.title,
    this.message,
    this.date,
    this.chequeNum,
  });

  ChequeNotif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    chequeNum = json['recept_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['date'] = date;
    data['chequeNum'] = chequeNum;
    return data;
  }
}
