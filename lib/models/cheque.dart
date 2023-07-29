import 'package:chequeproject/utils/validators.dart';

class Cheque {
  int? id;
  String? num;
  String? client;
  String? holder;
  double? montant;
  String? receptDate;
  String? echeanceDate;
  String? bank;
  String? isPayed;
  String? isEffet;
  String? paymentDate;
  String? attachement;
  String? reason;
  String? reasonPayment;
  String? forwardTo;

  Cheque(
      {this.id,
      this.num,
      this.client,
      this.holder,
      this.montant,
      this.receptDate,
      this.echeanceDate,
      this.bank,
      this.isPayed,
      this.isEffet,
      this.forwardTo,
      this.reasonPayment, 
      this.paymentDate,
      this.attachement,
      this.reason});

  Cheque.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    client = json['client'];
    holder = json['holder'];
    montant = validators.checkDouble(json['montant']);
    receptDate = json['recept_date'];
    echeanceDate = json['echeance_date'];
    bank = json['bank'];
    isPayed = json['is_payed'];
    isEffet = json['is_effet'];
    forwardTo= json['forward_to'];
    paymentDate = json['payment_date'];
    reasonPayment = json['reason_payment'];
    attachement = json['attachement'];     
  }

  Map<String, dynamic> toJson() {
    final data= <String, dynamic>{};
    data['id'] = id;
    data['num'] = num;
    data['client'] = client;
    data['holder'] = holder;
    data['montant'] = montant;
    data['recept_date'] = receptDate;
    data['echeance_date'] = echeanceDate;
    data['bank'] = bank;
    data['is_payed'] = isPayed;
    data['is_effet'] = isEffet;
    data['forward_to'] = forwardTo;
    data['payment_date'] = paymentDate;
    data['reason_payment']=reasonPayment;
    data['attachement'] = attachement;
    data['reason'] = reason;
    return data;
  }
}
