import 'package:dio/dio.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:http_parser/http_parser.dart';

class AddProductNetworking {
  addProduct({
    required String productName,
    required String productDescription,
    required String productTags,
    required String productTax,
    required String productIndicator,
    required String productQuantity,
    required String productQuantityMin,
    required String productStepSize,
    required String madeIn,
    required String productWarranty,
    required String productGurantee,
    required String isReturnable,
    required String isCodAvailable,
    required String isTaxAdded,
    required String isCancellable,
    required String mainImagePath,
    required productImages,
    required String videoPath,
    required String videoType,
    required String videoLink,
    required String productLevelDescription,
    required String categoryId,
    required String price,
  }) async {
    var formData = FormData.fromMap(
      {
        'seller_id': await getPrefrence(Id),
        'pro_input_name': productName,
        'short_description': productDescription,
        'tags': productTags,
        'pro_input_tax': productTax,
        'indicator': '1',
        'made_in': madeIn,
        'total_allowed_quantity': productQuantity,
        'minimum_order_quantity': productQuantityMin,
        'quantity_step_size': productStepSize,
        'warranty_period': productWarranty,
        'guarantee_period': productGurantee,
        'deliverable_type': "1",
        'deliverable_zipcodes': "0",
        'is_prices_inclusive_tax': isTaxAdded,
        'cod_allowed': isCodAvailable,
        'is_returnable': isReturnable,
        'is_cancelable': isCancellable,
        'cancelable_till': "received",
        'pro_input_image': await MultipartFile.fromFile(
          mainImagePath,
          filename: mainImagePath.split('/').last,
          contentType: MediaType('image', 'jpg'),
        ),
        'pro_input_image': "",
        // 'other_images': productImages,
        'other_images': "",
        'video_type': videoType == "0" ? "youtube" : "vimeo",
        'video': videoLink,
        // 'pro_input_video': await MultipartFile.fromFile(
        //   videoPath,
        //   filename: videoPath.split('/').last,
        //   contentType: MediaType('video', 'mp4'),
        // ),
        'pro_input_video': "",
        'pro_input_description': productLevelDescription,
        'category_id': categoryId,
        'attribute_values': '1,2,3',
        'simple_price': price,
        'product_type': "simple_product",
      },
    );
    Dio dio = Dio();
    Response response = await dio.post(
      'https://kladershopee.com/myadmin/seller/app/v1/api/add_products',
      data: formData,
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      print(response.data);

      print("msg${response.data}");

      return true;
      // Get.snackbar('Success', 'Data added successfully');
    } else
      print("error");
    return false;
    // Get.snackbar('Error', 'Something went wrong');
  }
}
