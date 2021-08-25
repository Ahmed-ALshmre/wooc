// import 'package:get/state_manager.dart';
// import 'package:wecc/controllwe/Catogre.dart';
// import 'package:wecc/model/model.dart';
// import 'package:woocommerce/models/product_category.dart';
// import 'package:woocommerce/models/products.dart';
//
//
// class ProductController extends GetxController {
//   var isLoading = true.obs;
//  var product = <Product>[].obs;
//   @override
//   void onInit() {
//     fetchFitterAddress();
//     super.onInit();
//   }
//
//   void fetchFitterAddress() async {
//     try {
//       isLoading(true);
//       final _filtter = await GetGatogre.getCatog();
//       if (_filtter != null) {
//        product.value = _filtter;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }