import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannersController extends GetxController {
  RxList<String> bunnersUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchBunnersUrls();
  }

  Future<void> fetchBunnersUrls() async {
    try {
      QuerySnapshot bunnerSnapshot =
          await FirebaseFirestore.instance.collection('bunners').get();

      if (bunnerSnapshot.docs.isNotEmpty) {
        bunnersUrls.value = bunnerSnapshot.docs
            .map((doc) => doc['imageUrl'] as String)
            .toList();
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
