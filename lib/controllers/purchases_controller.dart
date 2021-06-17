import '../imports_conflicts.dart';

class PurchasesController extends GetxController {
  var oneTimePurchases = <Package>[].obs;
  var subscriptions = <Package>[].obs;

  void addOneTimePuchases(List<Package> details) {
    for (var item in details) {
      bool exists = oneTimePurchases
          .any((element) => element.identifier == item.identifier);
      if (!exists) {
        oneTimePurchases.add(item);
      }
    }
  }

  void addSubscriptions(List<Package> details) {
    for (var item in details) {
      bool exists =
          subscriptions.any((element) => element.identifier == item.identifier);
      if (!exists) {
        subscriptions.add(item);
      }
    }
  }

  var purchases = <String>[].obs;

  void addPurchases(String purchaseIds) {
    if (!purchases.contains(purchaseIds)) {
      purchases.add(purchaseIds);
    }
  }

  var consumedPurchases = <String>[].obs;

  void addConsumedPurchases(String purchaseIds) {
    if (!consumedPurchases.contains(purchaseIds)) {
      consumedPurchases.add(purchaseIds);
    }
  }
}

final purchasesController = Get.put(PurchasesController());
