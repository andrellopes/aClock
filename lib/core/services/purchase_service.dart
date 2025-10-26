import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseService extends ChangeNotifier {
  /// Loads PRO status synchronously for ThemeManager initialization
  Future<void> loadPurchaseStatusSync() async {
    final prefs = await SharedPreferences.getInstance();
    _isProVersion = prefs.getBool(_kPurchaseStatusKey) ?? false;
  }
  static const String _kProVersionId = 'pro_version_aclock';
  static const String _kPurchaseStatusKey = 'pro_version_purchased';
  
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  
  bool _isAvailable = false;
  bool _isPurchasing = false;
  bool _isProVersion = false;
  List<ProductDetails> _products = [];
  String _purchaseError = '';

  bool get isAvailable => _isAvailable;
  bool get isPurchasing => _isPurchasing;
  bool get isProVersion => _isProVersion;
  List<ProductDetails> get products => _products;
  String get purchaseError => _purchaseError;
  String get proVersionId => _kProVersionId;

  PurchaseService() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Check if service is available
    _isAvailable = await _inAppPurchase.isAvailable();
    
    if (_isAvailable) {
      // Set up purchase listener
      final Stream<List<PurchaseDetails>> purchaseStream = _inAppPurchase.purchaseStream;
      _subscription = purchaseStream.listen(
        _onPurchaseUpdate,
        onDone: () => _subscription.cancel(),
        onError: (error) => debugPrint('Purchase stream error: $error'),
      );
      
      // Load products
      await _loadProducts();
      
      // Check pending purchases
      await _restorePurchases();
    }
    
    // Load status from SharedPreferences
    await _loadPurchaseStatus();
    
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    if (!_isAvailable) return;

    const Set<String> identifiers = {_kProVersionId};
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(identifiers);
    
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }
    
    _products = response.productDetails;
    notifyListeners();
  }

  Future<void> _loadPurchaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isProVersion = prefs.getBool(_kPurchaseStatusKey) ?? false;
    notifyListeners();
  }

  Future<void> _savePurchaseStatus(bool isPro) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kPurchaseStatusKey, isPro);
    _isProVersion = isPro;
    notifyListeners();
  }

  Future<void> buyProVersion() async {
    if (!_isAvailable || _isPurchasing) return;

    final ProductDetails? productDetails = _products
        .where((product) => product.id == _kProVersionId)
        .firstOrNull;

    if (productDetails == null) {
      _purchaseError = 'Product not found';
      notifyListeners();
      return;
    }

    _isPurchasing = true;
    _purchaseError = '';
    notifyListeners();

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _restorePurchases() async {
    if (!_isAvailable) return;

    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      _handlePurchase(purchaseDetails);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _kProVersionId) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _savePurchaseStatus(true);
          _isPurchasing = false;
          _purchaseError = '';
          break;
        case PurchaseStatus.error:
          _isPurchasing = false;
          _purchaseError = purchaseDetails.error?.message ?? 'Erro na compra';
          await _savePurchaseStatus(false);
          break;
        case PurchaseStatus.pending:
          _isPurchasing = true;
          _purchaseError = '';
          break;
        case PurchaseStatus.canceled:
          _isPurchasing = false;
          _purchaseError = '';
          break;
      }
    }

    // Complete the purchase
    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }

    notifyListeners();
  }

  ProductDetails? getProVersionProduct() {
    return _products.where((product) => product.id == _kProVersionId).firstOrNull;
  }

  Future<void> restorePurchases() async {
    await _restorePurchases();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
