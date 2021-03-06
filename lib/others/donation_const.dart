import '../imports.dart';
import '../imports_conflicts.dart';

const Map<String, String> donationsAddressMap = {
  "BTC(Preferred)": "35NgjpB3pzkdHkAPrNh2EMERGxnXgwCb6G",
  "ETH": "0xa81a32dcce8e5bcb9792daa19ae7f964699ee536",
  "UPI(Indian Users)": "pramukesh@upi",
  "Liberapay": "https://liberapay.com/canews.in/donate",
};

const Set<String> kGooglePlayPurchaseOneTimeIds = {
  'zeronet_one_1.00',
  'zeronet_one_5.00',
  'zeronet_one_15.00'
};

const Set<String> kGooglePlayPurchaseSubscriptionIds = {
  'zeronet_sub_1.00',
  'zeronet_sub_5.00',
  'zeronet_sub_15.00'
};

Future getInAppPurchases() async {
  Offerings offerings = await Purchases.getOfferings();
  if (offerings.current != null) {
    var onetimePurchases = (offerings.current.availablePackages.where(
      (element) => element.identifier.contains('zeronet_one'),
    )).toList();
    purchasesController.addOneTimePuchases(onetimePurchases);

    var subscriptions = (offerings.current.availablePackages.where(
      (element) => element.identifier.contains('zeronet_sub'),
    )).toList();
    purchasesController.addSubscriptions(subscriptions);
  }
}

Future<bool> isProUser() async {
  try {
    final userName = ''; // getZeroIdUserName();
    PurchaserInfo purchaserInfo;
    if (userName.isNotEmpty) purchaserInfo = await Purchases.identify(userName);
    purchaserInfo = await Purchases.getPurchaserInfo();
    if (purchaserInfo.entitlements.active.length > 0) return true;
  } on PlatformException catch (e) {
    // Error fetching purchaser info
  }
  return false;
}

void purchasePackage(Package package) async {
  try {
    PurchaserInfo purchaserInfo;
    final userName = ''; //getZeroIdUserName();
    if (userName.isNotEmpty) purchaserInfo = await Purchases.identify(userName);
    purchaserInfo = await Purchases.purchasePackage(package);

    var isPro = await isProUser();
    if (isPro) {
      // Unlock that great "pro" content
    }
    print(purchaserInfo);
  } on PlatformException catch (e) {
    var errorCode = PurchasesErrorHelper.getErrorCode(e);
    if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
      // showError(e);
    }
  }
}

void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      // showPendingUI();
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        Get.showSnackbar(
          GetBar(
            message:
                //!TODO Improve Error Messages sp that user can understand easily.
                'PurchaseStatus.error :: ${purchaseDetails.error.message}',
          ),
        );
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          deliverProduct(purchaseDetails);
        } else {
          // _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }

      if (purchaseDetails.productID != null &&
          purchaseDetails.productID.contains('zeronet_one')) {
        await InAppPurchaseConnection.instance.consumePurchase(purchaseDetails);
        purchasesController.addConsumedPurchases(purchaseDetails.purchaseID);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchaseConnection.instance
            .completePurchase(purchaseDetails);
      }
    }
  });
}

_verifyPurchase(PurchaseDetails purchaseDetails) {
  print(purchaseDetails.verificationData.localVerificationData);
  return Future<bool>.value(true);
}

void deliverProduct(PurchaseDetails purchaseDetails) async {
  // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
  if (purchaseDetails.productID.contains('zeronet_one')) {
    purchasesController.addPurchases(purchaseDetails.purchaseID);
  } else {}
}
