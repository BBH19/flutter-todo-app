// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/models/cheque.dart';

class ChequeService {
  static Future<List<Cheque>> getAll() async {
    List<Cheque>? list;
    var res = await http.get(Uri.parse('${GlobalParams.baseUrl}cheque'));
    var json_data = json.decode(res.body);
    //print(json_data);
    if (res.statusCode == 200) {
      var data = json_data as List;
      list = data.map<Cheque>((json) => Cheque.fromJson(json)).toList();
      print(list);
    } else {
      list = null;
    }
    return list!;
  }
   static Future<List<Cheque>> getFiltred(int days) async {
    List<Cheque>? list;
    var res = await http.get(Uri.parse('${GlobalParams.baseUrl}cheque/echeance/$days'));
    var json_data = json.decode(res.body);
    //print(json_data);
    if (res.statusCode == 200) {
      var data = json_data as List;
      list = data.map<Cheque>((json) => Cheque.fromJson(json)).toList();
      print(list);
    } else {
      list = null;
    }
    return list!;
  }

  static Future<bool> add(Cheque cheque) async {
    var body = json.encode(cheque.toJson());
    final response = await http.post(
      Uri.parse('${GlobalParams.baseUrl}cheque'),
      body: body,
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  static Future<bool> update(Cheque cheque) async {
    try {
      String url = '${GlobalParams.baseUrl}cheque/${cheque.id}';
      var body = json.encode(cheque.toJson());

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
