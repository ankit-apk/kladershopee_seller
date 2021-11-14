import 'dart:io';

import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/ContainerDesing.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Screen/register/geolocator.dart';
import 'package:eshopmultivendor/Screen/register/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    getPosition();
    super.initState();
  }

  var position;
  double latitude = 0.0;
  double longitude = 0.0;
  bool isTapped = false;
  getPosition() async {
    position = await determinePosition();
    print(position.latitude);
  }

  //Text Editing controllers;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController comissionController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeDescriptionController =
      TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController taxNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? mobile;

//image picker logic;

  File? addressProof;
  File? storeLogo;
  File? nationalIdentityCard;
  bool showAddresstick = false;
  bool showLogoTick = false;
  bool showIdentityTick = false;
  bool showLoading = false;

  Future getAddressImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    addressProof = File(pickedFile!.path);
    setState(
      () {
        showAddresstick = true;
      },
    );
  }

  Future getLogoImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    storeLogo = File(pickedFile!.path);
    setState(() {
      showLogoTick = true;
    });
  }

  Future getIdentityImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    nationalIdentityCard = File(pickedFile!.path);
    setState(() {
      showIdentityTick = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: back(),
            ),
            Positioned.directional(
              start: MediaQuery.of(context).size.width * 0.025,
              top: MediaQuery.of(context).size.height * 0.2,
              textDirection: Directionality.of(context),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.8,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                color: white,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Register',
                              style: const TextStyle(
                                color: primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          mobileController: nameController,
                          context: context,
                          hintText: "Name",
                          errorOne: "Please enter your name",
                          errorTwo: "Name should be atleast three letters",
                          validLength: 3,
                          iconData: Icons.people,
                        ),
                        TextFieldWidget(
                          mobileController: mobileController,
                          context: context,
                          hintText: "Mobile",
                          errorOne: "Please enter your mobile number",
                          errorTwo: "Number must be ten digits",
                          validLength: 9,
                          iconData: Icons.phone_android_sharp,
                          keyboard: TextInputType.number,
                        ),
                        TextFieldWidget(
                          mobileController: emailController,
                          context: context,
                          hintText: "Email",
                          errorOne: "Please enter your email",
                          errorTwo: "Please enter a valid email",
                          validLength: 3,
                          iconData: Icons.email,
                        ),
                        TextFieldWidget(
                          mobileController: passwordController,
                          context: context,
                          hintText: "Password",
                          errorOne: "Please create a password",
                          errorTwo: "Password must be atleast four digits",
                          validLength: 4,
                          iconData: Icons.password,
                        ),
                        TextFieldWidget(
                          mobileController: addressController,
                          context: context,
                          hintText: "Address",
                          errorOne: "Please enter your address",
                          errorTwo: "Address must be atleast six words",
                          validLength: 5,
                          iconData: Icons.location_city,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: showAddresstick,
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getAddressImage();
                              },
                              child: Text(
                                "Address proof",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isTapped == true
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const SizedBox(),
                            ElevatedButton(
                              onPressed: () async {
                                var pos = await determinePosition();
                                setState(() {
                                  latitude = pos.latitude;
                                  longitude = pos.longitude;
                                  isTapped = true;
                                });
                              },
                              child: Text(
                                "Shop Location",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldWidget(
                          mobileController: comissionController,
                          context: context,
                          hintText: "Comission",
                          errorOne: "Please enter comission percentage",
                          errorTwo: "Enter a valid percentage",
                          validLength: 1,
                          iconData: Icons.payment,
                          keyboard: TextInputType.number,
                        ),
                        TextFieldWidget(
                          mobileController: storeNameController,
                          context: context,
                          hintText: "Store Name",
                          errorOne: "Please enter your store name",
                          errorTwo: "Enter a valid name",
                          validLength: 1,
                          iconData: Icons.store,
                        ),
                        TextFieldWidget(
                          mobileController: storeDescriptionController,
                          context: context,
                          hintText: "Store Description",
                          errorOne: "Please enter a description",
                          errorTwo: "Enter a valid description",
                          validLength: 6,
                          iconData: Icons.description,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: showLogoTick,
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getLogoImage();
                              },
                              child: Text(
                                "Upload Store Logo",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldWidget(
                          mobileController: accountNumberController,
                          context: context,
                          hintText: "Account Number",
                          errorOne: "Please enter account number",
                          errorTwo: "Enter a valid account number",
                          validLength: 8,
                          iconData: Icons.payment,
                        ),
                        TextFieldWidget(
                          mobileController: accountNameController,
                          context: context,
                          hintText: "Account Name",
                          errorOne: "Please enter account name",
                          errorTwo: "Enter a valid name",
                          validLength: 3,
                          iconData: Icons.payment,
                        ),
                        TextFieldWidget(
                          mobileController: ifscCodeController,
                          context: context,
                          hintText: "IFSC Code",
                          errorOne: "Please enter ifsc code",
                          errorTwo: "Enter a valid ifsc",
                          validLength: 5,
                          iconData: Icons.payment,
                        ),
                        TextFieldWidget(
                          mobileController: bankNameController,
                          context: context,
                          hintText: "Bank Name",
                          errorOne: "Please enter bank name",
                          errorTwo: "Enter a valid name",
                          validLength: 2,
                          iconData: Icons.payment,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: showIdentityTick,
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getIdentityImage();
                              },
                              child: Text(
                                "Upload National ID Card",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldWidget(
                          mobileController: taxNameController,
                          context: context,
                          hintText: "Tax Payer Name",
                          errorOne: "Please enter name",
                          errorTwo: "Enter a valid name",
                          validLength: 3,
                          iconData: Icons.card_membership,
                        ),
                        TextFieldWidget(
                          mobileController: taxNumberController,
                          context: context,
                          hintText: "Tax Number",
                          errorOne: "Please enter number",
                          errorTwo: "Enter a valid number",
                          validLength: 8,
                          iconData: Icons.credit_card,
                        ),
                        TextFieldWidget(
                          mobileController: panNumberController,
                          context: context,
                          hintText: "PAN Number",
                          errorOne: "Please enter number",
                          errorTwo: "Enter a valid number",
                          validLength: 8,
                          iconData: Icons.credit_card,
                        ),
                        CupertinoButton(
                          child: Container(
                            width: 280,
                            height: 45,
                            alignment: FractionalOffset.center,
                            decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [grad1Color, grad2Color],
                                stops: [0, 1],
                              ),
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: showLoading == false
                                ? Text(
                                    "Register",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState!.validate() &&
                                latitude != 0.0) {
                              setState(() {
                                showLoading = true;
                              });
                              var res = await RegisterNetworking().register(
                                name: nameController.text,
                                number: mobileController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                address: addressController.text,
                                commission: comissionController.text,
                                storeName: storeNameController.text,
                                storeDescription:
                                    storeDescriptionController.text,
                                accountNumber: accountNumberController.text,
                                accountName: accountNameController.text,
                                bankCode: ifscCodeController.text,
                                bankName: bankNameController.text,
                                taxName: taxNameController.text,
                                panNumber: panNumberController.text,
                                addressProofPath: addressProof!.path,
                                latitude: latitude.toString(),
                                longitude: longitude.toString(),
                                logoPath: storeLogo!.path,
                                identityPath: nationalIdentityCard!.path,
                              );
                              if (res == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Text(
                                      "Account created successfully",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: black),
                                    ),
                                    backgroundColor: white,
                                    elevation: 1.0,
                                  ),
                                );
                                setState(() {
                                  showLoading = false;
                                  _formkey.currentState!.reset();
                                });
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Text(
                                      "Please check all the fields and try again",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: black),
                                    ),
                                    backgroundColor: white,
                                    elevation: 1.0,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width / 2) - 50,
              top: (MediaQuery.of(context).size.height * 0.2) - 50,
              child: SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset(
                  'assets/images/image2vector (1).svg',
                  // 'assets/images/loginlogo.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.mobileController,
    required this.context,
    required this.errorOne,
    required this.errorTwo,
    required this.hintText,
    required this.iconData,
    required this.validLength,
    this.keyboard,
  }) : super(key: key);

  final TextEditingController mobileController;
  final BuildContext context;
  final IconData iconData;
  final String hintText;
  final int validLength;
  final String errorOne;
  final String errorTwo;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: TextFormField(
        keyboardType: keyboard ?? TextInputType.name,
        controller: mobileController,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        textInputAction: TextInputAction.next,
        validator: (val) {
          if (val!.isEmpty) {
            return errorOne;
          }
          if (val.length < validLength) {
            return errorTwo;
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            color: lightBlack2,
            size: 20,
          ),
          hintText: hintText,
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                color: lightBlack2,
                fontWeight: FontWeight.normal,
              ),
          filled: true,
          fillColor: white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40,
            maxHeight: 20,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightBlack2),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
