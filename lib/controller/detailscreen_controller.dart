import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ufs_machinetest/model/details_model.dart';

class DetailscreenController with ChangeNotifier {
  bool isLoading = false;
  DetailResModel? detailObj;
  //to get detials of products
  Future<void> getDetails({required String id}) async {
    isLoading = true;
    notifyListeners();
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    if (response.statusCode == 200) {
      var resp = detailResModelFromJson(response.body);
      detailObj = resp;
    }
    isLoading = false;
    notifyListeners();
  }
}
