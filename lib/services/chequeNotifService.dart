import 'dart:convert';
import 'package:chequeproject/models/cheque_notif.dart';
import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:http/http.dart' as http; 

class ChequeNotifService {
  static Future<List<ChequeNotif>> getAll() async {
    List<ChequeNotif>? list;
    var res = await http.get(Uri.parse('${GlobalParams.baseUrl}notif'));
    var result = json.decode(res.body);
    //print(json_data);
    if (res.statusCode == 200) {
      var data = result as List;
      list =
          data.map<ChequeNotif>((json) => ChequeNotif.fromJson(json)).toList();
      print(list);
    } else {
      list = null;
    }
    return list!;
  }

  static Future<List<ChequeNotif>> getFiltred(int days) async {
    List<ChequeNotif>? list;
    var res = await http
        .get(Uri.parse('${GlobalParams.baseUrl}chequeNotif/echeance/$days'));
    var json_data = json.decode(res.body);
    //print(json_data);
    if (res.statusCode == 200) {
      var data = json_data as List;
      list =
          data.map<ChequeNotif>((json) => ChequeNotif.fromJson(json)).toList();
      print(list);
    } else {
      list = null;
    }
    return list!;
  }

  static Future<bool> add(ChequeNotif chequeNotif) async {
    var body = json.encode(chequeNotif.toJson());
    final response = await http.post(
      Uri.parse('${GlobalParams.baseUrl}chequeNotif'),
      body: body,
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  static Future<bool> update(ChequeNotif chequeNotif) async {
    try {
      String url = '${GlobalParams.baseUrl}chequeNotif/${chequeNotif.id}';
      var body = json.encode(chequeNotif.toJson());

      var res = await http.put(Uri.parse(url),
          body: body, headers: {'content-type': 'application/json'});
      if (res.statusCode == 200) {
        return true;
      }
    } on Exception catch (_, ex) {
      print(_);
    }
    return false;
  }
}
