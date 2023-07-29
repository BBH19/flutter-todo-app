// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:chequeproject/models/cheque.dart';

class ChequeService {
  static dynamic header={'content-type': 'application/json'};
  static Future<List<Cheque>> getAll(String param) async {
    List<Cheque>? list;
    var res = await http.get(Uri.parse('${GlobalParams.baseUrl}cheque/$param'));
    var json_data = json.decode(res.body);
    if (res.statusCode == 200) {
      var data = json_data as List;
      list = data.map<Cheque>((json) => Cheque.fromJson(json)).toList();
      print(list);
    } else {
      throw (res.body);
    }
    return list;
  }

  static Future<List<Cheque>> getFiltred(int days) async {
    List<Cheque>? list;
    var res = await http
        .get(Uri.parse('${GlobalParams.baseUrl}cheque/echeance/$days'));
    var json_data = json.decode(res.body); 
    if (res.statusCode == 200) {
      var data = json_data as List;
      list = data.map<Cheque>((json) => Cheque.fromJson(json)).toList();
      print(list);
    } else {
      throw (res.body);
    }
    return list;
  }

  static Future<bool> add(Cheque cheque) async {
    var body = json.encode(cheque.toJson());
    final response = await http.post(
      Uri.parse('${GlobalParams.baseUrl}cheque'),
      body: body,
      headers:ChequeService.header,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw (response.body);
    }
  }

  static Future<bool> update(Cheque cheque) async {
    String url = '${GlobalParams.baseUrl}cheque/${cheque.id}';
    var body = json.encode(cheque.toJson());

    var res = await http.put(Uri.parse(url),
        body: body,  headers:ChequeService.header, );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw (res.body);
    }
  }
}
