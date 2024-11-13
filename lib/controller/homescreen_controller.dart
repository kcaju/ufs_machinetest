import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ufs_machinetest/model/addproduct_model.dart';
import 'package:ufs_machinetest/model/product_model.dart';

class HomescreenController with ChangeNotifier {
  bool isProductLoading = false;
  List<ProductResModel> plist = [];
  AddProductResModel? addedProduct;
  //to fetch products
  Future<void> fetchProducts() async {
    isProductLoading = true;
    notifyListeners();
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        var res = productResModelFromJson(response.body);
        plist = res;
      }
    } catch (e) {
      print(e);
    }
    isProductLoading = false;
    notifyListeners();
  }
  //to add product

  Future<void> addProduct(
      {String? title,
      double? price,
      String? category,
      String? image,
      String? description}) async {
    try {
      final addResponse =
          await http.post(Uri.parse("https://fakestoreapi.com/products"),
              body: jsonEncode({
                title: title,
                price: price,
                description: description,
                image: image,
                category: category
              }));
      if (addResponse.statusCode == 200) {
        var resp = addProductResModelFromJson(addResponse.body);

        plist.add(ProductResModel(
          id: resp.id,
          title: resp.title,
          price: resp.price,
          description: resp.description,
          category: resp.category,
          image: resp.image,
        ));
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
  //to delete products

  Future<void> deleteProduct({required String id}) async {
    final deleteResp =
        await http.delete(Uri.parse("https://fakestoreapi.com/products/$id"));
    if (deleteResp.statusCode == 200) {
      plist.removeWhere(
        (product) => product.id == id,
      );
      notifyListeners();
    }
  }
}
