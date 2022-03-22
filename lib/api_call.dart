// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shweta_project/api_model.dart';
import 'package:http/http.dart' as http;

class ApiCall extends ChangeNotifier {
  ApiCall();
  ApiModel? _apiModel;
  List<ApiModel>? _apiModelList;

  bool _loading = false;
  bool _gettingAppConfigFailed = false;

  dynamic _errorInGettingAppConfig;

  List<ApiModel>? get apiModelList => this._apiModelList;

  ApiModel? get apiModel => this._apiModel;
  bool get loading => this._loading;
  bool get gettingAppConfigFailed => this._gettingAppConfigFailed;
  dynamic get errorInGettingAppConfig => this._errorInGettingAppConfig;

  void getList() async {
    this._loading = true;

    String? url = 'https://jsonplaceholder.typicode.com/albums/';

    http.Response? response;
    try {
      response = await http.get(Uri.parse(url));
      print(response.body);
    } catch (e) {
      print(e);
      this._gettingAppConfigFailed = false;
      this._errorInGettingAppConfig = e;
    }
    if (response != null) {
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        this._apiModelList = jsonResponse
            .map((apiModel) => ApiModel.fromJson(apiModel))
            .toList();
      } else {
        this._loading = false;
      }
    }

    notifyListeners();
  }
}
