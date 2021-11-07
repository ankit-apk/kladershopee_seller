import 'dart:async';
import 'dart:convert';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Constant.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';

class Terms_And_Condition extends StatefulWidget {
  const Terms_And_Condition({Key? key}) : super(key: key);

  @override
  _Terms_And_ConditionState createState() => _Terms_And_ConditionState();
}

class _Terms_And_ConditionState extends State<Terms_And_Condition> {
  bool _isLoading = true;
  bool _isNetworkAvail = true;
  String? termCondition;
  @override
  void initState() {
    super.initState();
    getSettings();
  }

  getSettings() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        Response response = await post(getSettingsApi, headers: headers)
            .timeout(Duration(seconds: timeOut));
        var getdata = json.decode(response.body);
        bool error = getdata["error"];
        String msg = getdata["message"];
        if (!error) {
          termCondition = getdata["data"]["terms_conditions"];
        } else {
          setSnackbar(msg);
        }
        setState(
          () {
            _isLoading = false;
          },
        );
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, "somethingMSg")!);
      }
    } else {
      setState(
        () {
          _isLoading = false;
          _isNetworkAvail = false;
        },
      );
    }
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: black),
        ),
        backgroundColor: white,
        elevation: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return _isLoading
        ? Scaffold(
            appBar: getAppBar(
              getTranslated(context, "TERM_CONDITIONS")!,
              context,
            ),
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : termCondition != null
            ? WebviewScaffold(
                appBar: getAppBar(
                  getTranslated(context, "TERM_CONDITIONS")!,
                  context,
                ),
                withJavascript: true,
                appCacheEnabled: true,
                scrollBar: false,
                url: new Uri.dataFromString(termCondition!,
                        mimeType: 'text/html', encoding: utf8)
                    .toString(),
              )
            : Scaffold(
                appBar: getAppBar(
                  getTranslated(context, "TERM_CONDITIONS")!,
                  context,
                ),
                body: _isNetworkAvail ? Container() : noInternet(context),
              );
  }
}

noInternet(BuildContext context) {
  return Container(
    child: Center(
      child: Text(getTranslated(context, "NoInternetAwailable")!),
    ),
  );
}
