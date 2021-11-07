import 'package:dio/dio.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:http_parser/http_parser.dart';

class RegisterNetworking {
  register({
    required String name,
    required String number,
    required String email,
    required String password,
    required String address,
    required String commission,
    required String storeName,
    required String storeDescription,
    required String accountNumber,
    required String accountName,
    required String bankCode,
    required String bankName,
    required String taxName,
    required String panNumber,
    required String addressProofPath,
    required String logoPath,
    required String identityPath,
  }) async {
    var formData = FormData.fromMap({
      'name': name,
      'mobile': number,
      'email': email,
      'password': password,
      'confirm_password': password,
      'status': '0',
      'address': address,
      'address_proof': await MultipartFile.fromFile(
        addressProofPath,
        filename: addressProofPath.split('/').last,
        contentType: MediaType('image', 'png'),
      ),
      'commission': commission,
      'store_name': storeName,
      'store_url': '',
      'store_description': storeDescription,
      'store_logo': await MultipartFile.fromFile(
        logoPath,
        filename: logoPath.split('/').last,
        contentType: MediaType('image', 'png'),
      ),
      'account_number': accountNumber,
      'account_name': accountName,
      'bank_code': bankCode,
      'bank_name': bankName,
      'other_status': 'a',
      'national_identity_card': await MultipartFile.fromFile(
        identityPath,
        filename: identityPath.split('/').last,
        contentType: MediaType('image', 'png'),
      ),
      'tax_name': taxName,
      'tax_number': taxNumber,
      'pan_number': panNumber,
    });
    Dio dio = Dio();
    Response response = await dio.post(
      'https://kladershopee.com/myadmin/seller/app/v1/api/seller_register',
      data: formData,
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      print(response.data);

      print("Done");

      return true;
      // Get.snackbar('Success', 'Data added successfully');
    } else
      print("error");
    return false;
    // Get.snackbar('Error', 'Something went wrong');
  }
}
