// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Constant.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/TaxesModel/TaxesModel.dart';
import 'package:eshopmultivendor/Screen/add_product/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key, this.res}) : super(key: key);
  var res;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
//------------------------------------------------------------------------------
//======================= Variable Declaration =================================

//image picker instances and variables
  final ImagePicker _picker = ImagePicker();
  List images = [];
  XFile? image = XFile("");
  XFile? videos;
  pickMultiImage() async {
    List<XFile>? pickedImages = await _picker.pickMultiImage();

    var arr = [];
    for (var img in pickedImages!) {
      arr.add(await MultipartFile.fromFile(img.path,
          filename: img.path.split('/').last));
      setState(() {
        images = arr;
      });
    }
  }

  pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage!;
    });
  }

  pickVideo() async {
    XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      videos = video;
    });
  }

//on-off toggles
  bool isToggled = false;
  bool isreturnable = false;
  bool isCODallow = false;
  bool iscancelable = false;
  bool taxincludedInPrice = false;

  bool _isNetworkAvail = true;
  bool _isLoading = true;
  String? data;
// Parameter For API Call
  String? productName; //pro_input_name
  String? sortDescription; // short_description
  String? longDescription; // long description
  String? tags; // Tags
  String? taxId; // Tax (pro_input_tax)
  int? selectedTaxID; //
  String? indicatorValue; // indicator
  String? totalAllowQuantity; // total_allowed_quantity
  String? minOrderQuantity; // minimum_order_quantity
  String? quantityStepSize; // quantity_step_size
  String? madeIn; //made_in
  String? warrantyPeriod; //warranty_period
  String? guaranteePeriod; //guarantee_period

  String? isReturnable = "0"; //is_returnable
  String? isCODAllow = "0"; //cod_allowed
  String? isCancelable = "0"; //is_cancelable
  String? taxincludedinPrice = "0"; //

  String? tillwhichstatus; //cancelable_till

  late StateSetter taxesState;
  List<TaxesModel> taxesList = [];

  String dropdownvalue = '--Select Category--';
  var items = [
    '--Select Category--',
  ];
  var itemsId = [];
  int selectedIndex = 0;

//------------------------------------------------------------------------------
//======================= TextEditingController ================================

  TextEditingController productNameControlller = TextEditingController();
  TextEditingController TagsControlller = TextEditingController();
  TextEditingController totalAllowController = TextEditingController();
  TextEditingController minOrderQuantityControlller = TextEditingController();
  TextEditingController quantityStepSizeControlller = TextEditingController();
  TextEditingController madeInControlller = TextEditingController();
  TextEditingController warrantyPeriodController = TextEditingController();
  TextEditingController guaranteePeriodController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
//------------------------------------------------------------------------------
//=================================== FocusNode ================================

  FocusNode? productFocus,
      sortDescriptionFocus,
      longDescriptionFocus,
      tagFocus,
      totalAllowFocus,
      minOrderFocus,
      quantityStepSizeFocus,
      madeInFocus,
      warrantyPeriodFocus,
      guaranteePeriodFocus = FocusNode();

//------------------------------------------------------------------------------
//========================= InIt MEthod ========================================

  @override
  void initState() {
    super.initState();

    var categories = widget.res["data"]["category"];

    for (var category in categories) {
      items.add(category["name"]);
      itemsId.add(category["id"]);
    }
    print("item length ${itemsId.length}");

    // getTax();
  }

//------------------------------------------------------------------------------
//======================== getTax API ==========================================

  // getTax() async {
  //   _isNetworkAvail = await isNetworkAvailable();
  //   if (_isNetworkAvail) {
  //     try {
  //       Response response = await post(getTaxesApi, headers: headers)
  //           .timeout(Duration(seconds: timeOut));
  //       var getdata = json.decode(response.body);
  //       print(getdata);
  //       bool error = getdata["error"];
  //       String msg = getdata["message"];
  //       if (!error) {
  //         var data = getdata["data"];
  //         taxesList = (data as List)
  //             .map((data) => new TaxesModel.fromJson(data))
  //             .toList();
  //       } else {
  //         setSnackbar(msg);
  //       }
  //       setState(
  //         () {
  //           _isLoading = false;
  //         },
  //       );
  //     } on TimeoutException catch (_) {
  //       setSnackbar(getTranslated(context, "somethingMSg")!);
  //     }
  //   } else {
  //     setState(
  //       () {
  //         _isLoading = false;
  //         _isNetworkAvail = false;
  //       },
  //     );
  //   }
  // }

//------------------------------------------------------------------------------
//======================= setSnackbar ==========================================

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

//------------------------------------------------------------------------------
//================================= ProductName ================================

// logic clear....

  addProductName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        productText(),
        productTextField(),
      ],
    );
  }

  productText() {
    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 15,
      ),
      child: Text(
        getTranslated(context, "PRODUCTNAME_LBL")!,
        style: TextStyle(
          fontSize: 18,
          color: black,
        ),
      ),
    );
  }

  productTextField() {
    return Container(
      width: width,
      height: 50,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(productFocus);
        },
        focusNode: productFocus,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        controller: productNameControlller,
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        onChanged: (value) {
          productName = value;
        },
        validator: (val) => validateProduct(val, context),
        decoration: InputDecoration(
          hintText: getTranslated(context, "PRODUCTHINT_TXT")!,
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
//=========================== ShortDescription =================================

// logic clear

  shortDescription() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Short Description ",
            style: TextStyle(
              fontSize: 18,
              color: black,
            ),
          ),
          SizedBox(
            height: 05,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white10,
              border: Border.all(
                color: lightBlack,
                width: 1,
              ),
            ),
            width: width,
            height: height * 0.12,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: TextFormField(
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(sortDescriptionFocus);
                },
                focusNode: sortDescriptionFocus,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                validator: (val) => sortdescriptionvalidate(val, context),
                onChanged: (value) {
                  sortDescription = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: fontColor,
                    fontSize: 14,
                  ),
                  hintText: "Add Sort Detail of Product ...!",
                ),
                minLines: null,
                maxLines:
                    null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                expands:
                    true, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
              ),
            ),
          ),
        ],
      ),
    );
  }

  productDescription() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Description ",
            style: TextStyle(
              fontSize: 18,
              color: black,
            ),
          ),
          SizedBox(
            height: 05,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white10,
              border: Border.all(
                color: lightBlack,
                width: 1,
              ),
            ),
            width: width,
            height: height * 0.12,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: TextFormField(
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(longDescriptionFocus);
                },
                focusNode: longDescriptionFocus,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                validator: (val) => sortdescriptionvalidate(val, context),
                onChanged: (value) {
                  longDescription = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: fontColor,
                    fontSize: 14,
                  ),
                  hintText: "Add Detail of Product ...!",
                ),
                minLines: null,
                maxLines:
                    null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                expands:
                    true, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//================================= Tags Add ===================================

  // logic clear

  tagsAdd() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tagsText(),
          addTagName(),
        ],
      ),
    );
  }

  tagsText() {
    return Row(
      children: [
        Text(
          "Tags",
          style: TextStyle(
            fontSize: 18,
            color: black,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            "(These tags help you in search result)",
            style: TextStyle(
              color: Colors.grey,
            ),
            softWrap: false,
          ),
        ),
      ],
    );
  }

  addTagName() {
    return Container(
      width: width,
      height: 50,
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(tagFocus);
        },
        focusNode: tagFocus,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        controller: TagsControlller,
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        onChanged: (value) {
          tags = value;
          print(tags);
        },
        validator: validateTags,
        decoration: InputDecoration(
          hintText:
              "Type in some tags for example AC, Cooler, Flagship Smartphones, Mobiles, Sport etc..",
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
      ),
    );
  }

  String? validateTags(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Tags";
    }
    if (value.length < 2) {
      return "minimam 2 character is required ";
    }
    return null;
  }

//------------------------------------------------------------------------------
//============================== Tax Selection =================================

  // Logic clear

  taxSelection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: lightBlack,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: selectedTaxID != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taxesList[selectedTaxID!].title!,
                          ),
                          Text(
                            taxesList[selectedTaxID!].percentage!,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Tax",
                          ),
                          Text(
                            "0%",
                          ),
                        ],
                      ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: fontColor,
              )
            ],
          ),
        ),
        onTap: () {
          taxesDialog();
        },
      ),
    );
  }

  taxesDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            taxesState = setStater;
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Tax',
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: fontColor),
                        ),
                        Text(
                          '%0',
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: fontColor),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: lightBlack),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getTaxtList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> getTaxtList() {
    return taxesList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                if (mounted)
                  setState(
                    () {
                      selectedTaxID = index;
                      taxId = taxesList[selectedTaxID!].id;
                      Navigator.of(context).pop();
                    },
                  );
              },
              child: Container(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        taxesList[index].title!,
                      ),
                      Text(
                        taxesList[index].percentage! + "%",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

//------------------------------------------------------------------------------
//========================= Indicator Selection ================================

// Logic clear

  indicatorField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 5,
              right: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: lightBlack,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      indicatorValue != null
                          ? Text(indicatorValue == '0'
                              ? "None"
                              : indicatorValue == '1'
                                  ? "Veg"
                                  : "Non-Veg")
                          : Text(
                              "Select Indicator",
                            ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: fontColor,
                )
              ],
            )),
        onTap: () {
          indicatorDialog();
        },
      ),
    );
  }

  indicatorDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            taxesState = setStater;
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Indicator',
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: fontColor),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: lightBlack),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  indicatorValue = '0';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "None",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  indicatorValue = '1';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Veg",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  indicatorValue = '2';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Non-Veg",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

//------------------------------------------------------------------------------
//========================= TotalAllow Quantity ================================

//logic clear

  totalAllowedQuantity() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Total Allowed Quantity" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(totalAllowFocus);
              },
              keyboardType: TextInputType.number,
              controller: totalAllowController,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: totalAllowFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                totalAllowQuantity = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//========================= Minimum Order Quantity =============================

//logic clear

  minimumOrderQuantity() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Minimum Order Quantity" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(minOrderFocus);
              },
              keyboardType: TextInputType.number,
              controller: minOrderQuantityControlller,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: minOrderFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                minOrderQuantity = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//========================= Quantity Step Size =================================

//logic clear

  _quantityStepSize() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Quantity Step Size" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(quantityStepSizeFocus);
              },
              keyboardType: TextInputType.number,
              controller: quantityStepSizeControlller,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: quantityStepSizeFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                quantityStepSize = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//=================================== Made In ==================================

//logic clear

  _madeIn() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Made In" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(madeInFocus);
              },
              keyboardType: TextInputType.text,
              controller: madeInControlller,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: madeInFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
              onChanged: (String? value) {
                madeIn = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//============================ Warranty Period =================================

//logic clear

  _warrantyPeriod() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Warranty Period" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(warrantyPeriodFocus);
              },
              keyboardType: TextInputType.text,
              controller: warrantyPeriodController,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: warrantyPeriodFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                warrantyPeriod = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//============================ Guarantee Period ================================

//logic clear

  _guaranteePeriod() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 8,
            ),
            child: Container(
              width: width * 0.4,
              child: Text(
                "Guarantee Period" + " :",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: width * 0.5,
            padding: EdgeInsets.only(),
            child: TextFormField(
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(guaranteePeriodFocus);
              },
              keyboardType: TextInputType.text,
              controller: guaranteePeriodController,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.normal,
              ),
              focusNode: guaranteePeriodFocus,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                guaranteePeriod = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//========================= select Category Header =============================

  SelectCategory() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryField(),
        ],
      ),
    );
  }

  CategoryField() {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: selectedTaxID != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taxesList[selectedTaxID!].title!,
                          ),
                          Text(
                            taxesList[selectedTaxID!].percentage!,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Categories",
                          ),
                        ],
                      ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: fontColor,
              )
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }

//------------------------------------------------------------------------------
//============================= Is Returnable ==================================

  _isReturnable() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Is Returnable ?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          FlutterSwitch(
            height: 20.0,
            width: 40.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 10.0,
            activeColor: primary,
            value: isreturnable,
            onToggle: (value) {
              setState(
                () {
                  isreturnable = value;
                  if (value) {
                    isReturnable = "1";
                  } else {
                    isReturnable = "0";
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//============================= Is COD allowed =================================

  _isCODAllow() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Is COD allowed ?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          FlutterSwitch(
            height: 20.0,
            width: 40.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 10.0,
            activeColor: primary,
            value: isCODallow,
            onToggle: (value) {
              setState(
                () {
                  isCODallow = value;
                  if (value) {
                    isCODAllow = "1";
                  } else {
                    isCODAllow = "0";
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//=========================== Tax included in prices ===========================

  taxIncludedInPrice() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Tax included in prices ?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          FlutterSwitch(
            height: 20.0,
            width: 40.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 10.0,
            activeColor: primary,
            value: taxincludedInPrice,
            onToggle: (value) {
              setState(
                () {
                  taxincludedInPrice = value;
                  if (value) {
                    taxincludedinPrice = "1";
                  } else {
                    taxincludedinPrice = "0";
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//============================= Is Cancelable ==================================

  _isCancelable() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Is Cancelable ?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          FlutterSwitch(
            height: 20.0,
            width: 40.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 10.0,
            activeColor: primary,
            value: iscancelable,
            onToggle: (value) {
              setState(
                () {
                  iscancelable = value;
                  if (value) {
                    isCancelable = "1";
                  } else {
                    isCancelable = "0";
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
//============================= Till which status ==============================

  tillWhichStatus() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 5,
              right: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: lightBlack,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tillwhichstatus != null
                          ? Text(tillwhichstatus == 'received'
                              ? "Received"
                              : tillwhichstatus == 'processed'
                                  ? "Processed"
                                  : "Shipped")
                          : Text(
                              "Till which status",
                            ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: fontColor,
                )
              ],
            )),
        onTap: () {
          tillWhichStatusDialog();
        },
      ),
    );
  }

  tillWhichStatusDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            taxesState = setStater;
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tillwhichstatus = 'received';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Received",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tillwhichstatus = 'processed';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Processed",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tillwhichstatus = 'shipped';
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Shipped",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
//------------------------------------------------------------------------------
//========================= select Category Header =============================

  tenHeader() {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Main Image * "),
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 90,
              height: 40,
              child: Center(
                child: Text(
                  "Upload ",
                  style: TextStyle(
                    color: white,
                  ),
                ),
              ),
            ),
            image!.path != "" ? Icon(Icons.check) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  elevanHeader() {
    return GestureDetector(
      onTap: () {
        pickMultiImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Other Images  "),
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 90,
              height: 40,
              child: Center(
                child: Text(
                  "Upload ",
                  style: TextStyle(
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }

  tweelHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Video Type"),
          VideoTypeField(),
          Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 90,
            height: 40,
            child: Center(
              child: Text(
                "Upload ",
                style: TextStyle(
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  VideoTypeField() {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    indicatorValue != null
                        ? Text(indicatorValue == '0'
                            ? "None"
                            : indicatorValue == '1'
                                ? "Self Hosted"
                                : indicatorValue == '2'
                                    ? "Youtube"
                                    : "Vimeo")
                        : Text(
                            "Select Indicator",
                          ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: fontColor,
              )
            ],
          ),
        ),
        onTap: () {
          indicatorDialog();
        },
      ),
    );
  }

  AdditionalInfo() {
    return Column(
      children: [
        Container(
          width: width,
          child: Text("Additional Info"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: lightWhite2,
            ),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("General"),
                Text("Type Of Product :"),
              ],
            ),
          ),
        ),
      ],
    );
  }

//==============================================================================
//=========================== Description ========================================

  Description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description :"),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white10,
              border: Border.all(
                color: primary,
              ),
            ),
            width: width,
            height: height * 0.2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: null,
                maxLines:
                    null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                expands:
                    true, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
              ),
            ),
          ),
        ],
      ),
    );
  }

//==============================================================================
//=========================== Add Product Button ========================================

  AddProButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // InkWell(
        //   onTap: () {
        //     //Impliment here
        //   },
        //   child: Container(
        //     height: 50,
        //     width: 150,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: lightBlack2,
        //     ),
        //     child: Center(
        //       child: Text(
        //         "Reset",
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        InkWell(
          onTap: () async {
            //Impliment here

            var res = await AddProductNetworking().addProduct(
              productName: productName ?? "sd",
              productDescription: sortDescription ?? "as",
              productTags: tags ?? "ac",
              productTax: taxController.text,
              productIndicator: indicatorValue ?? "1",
              productQuantity: totalAllowQuantity ?? "2",
              productQuantityMin: minOrderQuantity ?? "2",
              productStepSize: quantityStepSize ?? "2",
              madeIn: madeIn ?? "2",
              productWarranty: warrantyPeriod ?? "3",
              productGurantee: guaranteePeriod ?? "2",
              isReturnable: isReturnable ?? "2",
              isCodAvailable: isCODAllow ?? "1",
              isTaxAdded: taxincludedInPrice.toString(),
              isCancellable: isCancelable ?? "0",
              mainImagePath: image!.path,
              // productImages: images,
              // videoPath: videos!.path,
              // mainImagePath: "",
              productImages: [],
              videoPath: "",
              videoType: "0",
              videoLink: youtubeController.text,
              productLevelDescription: longDescription!,
              categoryId: itemsId[selectedIndex],
              price: priceController.text,
            );
            if (res == true) {
              Navigator.pop(context);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product added successfully'),
                ),
              );
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not add product'),
                ),
              );
            }
          },
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                "Add Product",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//==============================================================================
//=========================== Body Part ========================================

  getBodyPart() {
    return SingleChildScrollView(
      child: Column(
        children: [
          addProductName(),
          shortDescription(),
          tagsAdd(),
          SizedBox(
            height: 10,
          ),
          DropdownButton(
            value: dropdownvalue,
            icon: Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                dropdownvalue = newValue.toString();
                selectedIndex = items.indexOf(dropdownvalue) - 1;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Price",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: taxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Tax Percentage",
              ),
            ),
          ),
          // taxSelection(),
          indicatorField(),
          totalAllowedQuantity(),
          minimumOrderQuantity(),
          _quantityStepSize(),
          _madeIn(),
          _warrantyPeriod(),
          _guaranteePeriod(),
          SelectCategory(),
          _isReturnable(),
          _isCODAllow(),
          taxIncludedInPrice(),
          _isCancelable(),
          isCancelable == "1" ? tillWhichStatus() : Container(),
          //
          tenHeader(),
          // elevanHeader(),
          // GestureDetector(
          //   onTap: () {
          //     pickVideo();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       // crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Product Video  "),
          //         Container(
          //           decoration: BoxDecoration(
          //             color: primary,
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           width: 90,
          //           height: 40,
          //           child: Center(
          //             child: Text(
          //               "Upload ",
          //               style: TextStyle(
          //                 color: white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: youtubeController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Youtube Link*",
              ),
            ),
          ),
          // tweelHeader(),
          // AdditionalInfo(),
          // Description(),
          productDescription(),
          AddProButton(),
          Container(
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar("Add New Product", context),
      body: getBodyPart(),
    );
  }
}
