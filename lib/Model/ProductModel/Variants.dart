// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:eshopmultivendor/Helper/String.dart';

class Product_Varient {
  String? id,
      productId,
      attribute_value_ids,
      price,
      disPrice,
      type,
      attr_name,
      varient_value,
      availability,
      cartCount,
      stock;
  List<String>? images;

  Product_Varient(
      {this.id,
      this.productId,
      this.attr_name,
      this.varient_value,
      this.price,
      this.disPrice,
      this.attribute_value_ids,
      this.availability,
      this.cartCount,
      this.stock,
      this.images});

  factory Product_Varient.fromJson(Map<String, dynamic> json) {
    List<String> images = List<String>.from(json[Images]);

    return new Product_Varient(
        id: json[Id],
        attribute_value_ids: json[AttributeValueIds],
        productId: json[ProductId],
        attr_name: json[AttrName],
        varient_value: json[VariantValues],
        disPrice: json[SpecialPrice],
        price: json[Price],
        availability: json[Availability].toString(),
        cartCount: json[CartCount],
        stock: json[Stock],
        images: images);
  }
}
