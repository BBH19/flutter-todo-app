class Cheque {
  String? id;
  String? client;
  String? holder;
  double? montant;
  String? receptDate;
  String? echeanceDate;
  String? bank;
  String? isPayed;
  String? paymentDate;
  String? attachement;

  Cheque(
      {this.id,
      this.client,
      this.holder,
      this.montant,
      this.receptDate,
      this.echeanceDate,
      this.bank,
      this.isPayed,
      this.paymentDate,
      this.attachement});

  Cheque.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    holder = json['holder'];
    montant = json['montant'];
    receptDate = json['recept_date'];
    echeanceDate = json['echeance_date'];
    bank = json['bank'];
    isPayed = json['is_payed'];
    paymentDate = json['payment_date'];
    attachement = json['attachement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client'] = client;
    data['holder'] = holder;
    data['montant'] = montant;
    data['recept_date'] = receptDate;
    data['echeance_date'] = echeanceDate;
    data['bank'] = bank;
    data['is_payed'] = isPayed;
    data['payment_date'] = paymentDate;
    data['attachement'] = attachement;
    return data;
  }
}
