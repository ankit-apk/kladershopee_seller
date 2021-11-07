// ignore_for_file: non_constant_identifier_names

import 'Constant.dart';

//==============================================================================
//========================= All API's here =====================================

final Uri getUserLoginApi = Uri.parse(baseUrl + 'login');
final Uri getOrdersApi = Uri.parse(baseUrl + 'get_orders');
final Uri getOrderItemsApi = Uri.parse(baseUrl + 'get_order_items');
final Uri updateOrderItemApi = Uri.parse(baseUrl + 'update_order_item_status');
final Uri getCategoriesApi = Uri.parse(baseUrl + 'get_categories');
final Uri getProductsApi = Uri.parse(baseUrl + 'get_products');
final Uri getCustomersApi = Uri.parse(baseUrl + 'get_customers');
final Uri getTransactionsApi = Uri.parse(baseUrl + 'get_transactions');
final Uri getStatisticsApi = Uri.parse(baseUrl + 'get_statistics');
final Uri forgotPasswordApi = Uri.parse(baseUrl + 'forgot_password');
final Uri deleteOrderApi = Uri.parse(baseUrl + 'delete_order');
final Uri verifyUserApi = Uri.parse(baseUrl + 'verify_user');
final Uri getSettingsApi = Uri.parse(baseUrl + 'get_settings');
final Uri updateFcmApi = Uri.parse(baseUrl + 'update_fcm');
final Uri getCitiesApi = Uri.parse(baseUrl + 'get_cities');
final Uri getAreasByCityIdApi = Uri.parse(baseUrl + 'get_areas_by_city_id');
final Uri getZipcodesApi = Uri.parse(baseUrl + 'get_zipcodes');
final Uri getTaxesApi = Uri.parse(baseUrl + 'get_taxes');
final Uri sendWithDrawalRequestApi =
    Uri.parse(baseUrl + 'send_withdrawal_request');
final Uri getWithDrawalRequestApi =
    Uri.parse(baseUrl + 'get_withdrawal_request');
final Uri getAttributeSetApi = Uri.parse(baseUrl + 'get_attribute_set');
final Uri getAttributesApi = Uri.parse(baseUrl + 'get_attributes');
final Uri getAttributrValuesApi = Uri.parse(baseUrl + 'get_attribute_values');
final Uri addProductsApi = Uri.parse(baseUrl + 'add_products');
final Uri getMediaApi = Uri.parse(baseUrl + 'get_media');
final Uri getSellerDetails = Uri.parse(baseUrl + 'get_seller_details');
final Uri updateUserApi = Uri.parse(baseUrl + 'update_user');
final Uri getDeliveryBoysApi = Uri.parse(baseUrl + 'get_delivery_boys');

//==============================================================================
//========================= Parameter for API's ================================
//STRING WHICH CAN BE CHANGED
final String isLogin = '$appName+_islogin';
String? CUR_USERID = '';
String? CUR_USERNAME = "";
String CUR_CURRENCY = ' ';
String CUR_BALANCE = '';
String LOGO = '';
String RATTING = '';
String NO_OFF_RATTING = '';

//permission's
bool readProduct = true;
bool readOrder = true;

const String Mobile = 'mobile';
const String Password = 'password';
const String STATUS = "status";
const String Delivery_Boy_Id = "delivery_boy_id";
const String SORT = "sort";
const String mobileno = "mobile_no";
const String NEWPASS = 'new';
const String OLDPASS = 'old';
const String ORDER_ID = 'order_id';
String UserId = "user_id";
const String Id = 'id';
const String IDS = 'ids';
const String amount = "amount";
const String Amount = "amount";

//==============================================================================
//========================= Other String's =====================================

const String Username = 'username';
const String Email = 'email';
const String City = "city";
const String Area = 'area';
const String Address = 'address';
const String Pincode = 'pincode';
const String IMage = 'image';
const String Storename = 'store_name';
const String Storeurl = 'store_url';
const String storeDescription = 'store_description';
const String accountNumber = 'account_number';
const String accountName = 'account_name';
const String bankCode = 'bank_code';
const String bankName = 'bank_name';
const String taxName = 'tax_name';
const String taxNumber = 'tax_number';
const String panNumber = 'pan_number';
const String StoreLogo = "logo";
String LIMIT = "limit";

const String SHIPED = 'shipped';
const String PROCESSED = 'processed';
const String DELIVERD = 'delivered';
const String CANCLED = 'cancelled';
const String RETURNED = 'returned';
const String WAITING = 'awaiting';

//============================ For Model Class =================================

const String AttrName = 'attr_name';
const String VALUE = 'value';
const String SwatchType = 'swatche_type';
const String SwatcheValue = 'swatche_value';
const String ProductId = 'product_id';
const String AttributeValueIds = 'attribute_value_ids';
const String AttributeSet = 'attribute_set';
const String Price = 'price';
const String SpecialPrice = 'special_price';
const String Availability = 'availability';
const String stock = 'stock';
const String Stock = 'stock';
const String Images = 'images';
const String VarientValue = 'variant_ids';
const String DateAdded = 'date_added';
const String Sku = 'sku';
const String CartCount = 'cart_count';
const String VariantIds = 'variant_ids';
const String Status = 'status';
const String MinPrice = 'min_price';
const String MaxPrice = 'max_price';
const String MaxSpecialPrice = 'max_special_price';
const String DiscountInPercentage = 'discount_in_percentage';
const String Total = 'total';
const String Sales = 'sales';
const String StockType = 'stock_type';
const String IsPricesInclusiveTax = 'is_prices_inclusive_tax';
const String Type = 'type';
const String AttrValueIds = 'attr_value_ids';
const String StoreName = 'store_name';
const String SellerName = 'seller_name';
const String Name = 'name';
const String CategoryId = 'category_id';
const String ShortDescription = 'short_description';
const String Slug = 'slug';
const String Description = 'description';
const String TotalAllowedQuantity = 'total_allowed_quantity';
const String DeliverableType = 'deliverable_type';
const String DeliverableZipcodes = 'deliverable_zipcodes';
const String MinimumOrderQuantity = 'minimum_order_quantity';
const String QuantityStepSize = 'quantity_step_size';
const String CodAllowed = 'cod_allowed';
const String RowOrder = 'row_order';
const String Rating = 'rating';
const String NoOfRatings = 'no_of_ratings';
const String IsReturnable = 'is_returnable';
const String IsCancelable = 'is_cancelable';
const String CancelableTill = 'cancelable_till';
const String Indicator = 'indicator';
const String OtherImages = 'other_images';
const String VideoType = 'video_type';
const String Video = 'video';
const String WarrantyPeriod = 'warranty_period';
const String GuaranteePeriod = 'guarantee_period';
const String MadeIn = 'made_in';
const String CategoryName = 'category_name';
const String TaxPercentage = 'tax_percentage';
const String ReviewImages = 'review_images';
const String Attributes = 'attributes';
const String DeliverableZipcodesIds = 'deliverable_zipcodes_ids';
const String IsDeliverable = 'is_deliverable';
const String IsPurchased = 'is_purchased';
const String IsFavorite = 'is_favorite';
const String ImageMd = 'image_md';
const String ImageSm = 'image_sm';
const String OtherImagesSm = 'other_images_sm';
const String OtherImagesMd = 'other_images_md';
const String VariantAttributes = 'variant_attributes';
const String Tags = 'tags';
const String Variants = 'variants';
const String MinmaxPrice = 'min_max_price';
const String PaymentType = 'payment_type';
const String PaymentAddress = 'payment_address';
const String AmountRequested = 'amount_requested';
const String Remarks = 'remarks';
const String DateCreated = 'date_created';
const String AddressId = 'address_id';
const String DeliveryCharge = 'delivery_charge';
const String IsDeliveryChargeReturnable = 'is_delivery_charge_returnable';
const String WalletBalance = 'wallet_balance';
const String PromoCode = 'promo_code';
const String PromoDiscount = 'promo_discount';
const String Discount = 'discount';
const String TotalPayable = 'total_payable';
const String FinalTotal = 'final_total';
const String PaymentMethod = 'payment_method';
const String Latitude = 'latitude';
const String Longitude = 'longitude';
const String DeliveryTime = 'delivery_time';
const String DeliveryDate = 'delivery_date';
const String Otp = 'otp';
const String Country_Code = 'country_code';
const String IsAlreadyReturned = 'is_already_returned';
const String IsAlreadyCancelled = 'is_already_cancelled';
const String ReturnRequestSubmitted = 'return_request_submitted';
const String TotalTaxPercent = 'total_tax_percent';
const String TotalTaxAmount = 'total_tax_amount';
const String Attachments = 'attachments';
const String OrderItemss = 'order_items';
const String IsCredited = 'is_credited';
const String ProductName = 'product_name';
const String VariantName = 'variant_name';
const String ProductVariantId = 'product_variant_id';
const String Quantity = 'quantity';
const String DiscountedPrice = 'discounted_price';
const String TaxPercent = 'tax_percent';
const String TaxAmount = 'tax_amount';
const String SubTotal = 'sub_total';
const String DeliverBy = 'deliver_by';
const String ActiveStatus = 'active_status';
const String OrderCounter = 'order_counter';
const String OrderCancelCounter = 'order_cancel_counter';
const String OrderReturn_counter = 'order_return_counter';
const String OrderReturnCounter = 'order_return_counter';
const String VaraintIds = 'varaint_ids';
const String VariantValues = 'variant_values';
const String AttributeValues = 'attribute_values';
const String AttributeValuesId = 'attribute_values_id';
const String OFFSET = 'offset';
const String awaitingPayment = 'Awaiting Payment';
const String SellerId = "seller_id";
const String COUNTRY_CODE = 'country_code';
const String PRODUCT_DETAIL = 'product_details';
const String FILTERS = 'filters';
const String TAX = 'tax';
const String BANNER = 'banner';
const String TOP_RETAED = 'top_rated_product';
const String FLAG = 'flag';
const String ALL = 'all';
const String PLACED = 'received';
const String START_DATE = 'start_date';
const String END_DATE = 'end_date';
const String STREET = 'street';
const String BALANCE = 'balance';
const String ORDERID = 'order_id';
const String ORDERITEMID = 'order_item_id';
const String DEL_BOY_ID = 'delivery_boy_id';
const String ATTACHMENT = 'attachment';
const String Title = 'title';
const String Percentage = 'percentage';

const String PENDINg = 'Pending';
const String ACCEPTEd = 'Accepted';
const String REJECTEd = 'Rejected';
const String SEARCH = 'search';
const String Order = "order";
