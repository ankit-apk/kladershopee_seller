import 'dart:convert';

import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchCategoryNetworking {
  var client = http.Client();

  fetchCategory() async {
    var response = await client.post(
      Uri.parse(
          "https://kladershopee.com/myadmin/seller/app/v1/api/get_seller_category"),
      body: {
        "seller_id": CUR_USERID!,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
