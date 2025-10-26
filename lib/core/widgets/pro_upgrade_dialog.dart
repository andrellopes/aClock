import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../themes/theme_manager.dart';
import '../services/purchase_service.dart';

class ProUpgradeDialog extends StatelessWidget {
  const ProUpgradeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<PurchaseService>(
      builder: (context, purchaseService, child) {
        final proProduct = purchaseService.getProVersionProduct();

        // Closes the dialog automatically after successful purchase
        if (purchaseService.isProVersion) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).maybePop();
          });
        }

        return AlertDialog(
          backgroundColor: themeManager.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.upgradeToProTitle,
                  style: TextStyle(
                    color: themeManager.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.upgradeToProDesc,
                  style: TextStyle(
                    color: themeManager.secondaryTextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(Icons.block, l10n.noAds, themeManager),
                _buildFeatureItem(Icons.palette, l10n.exclusiveThemes, themeManager),
                _buildFeatureItem(Icons.support, l10n.supportDeveloper, themeManager),
                
                if (purchaseService.purchaseError.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 25.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withValues(alpha: 76.5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            purchaseService.purchaseError,
                            style: const TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.cancel,
                style: TextStyle(color: themeManager.secondaryTextColor),
              ),
            ),
            if (!purchaseService.isAvailable)
              TextButton(
                onPressed: null,
                child: Text(
                  l10n.unavailable,
                  style: TextStyle(color: themeManager.mutedTextColor),
                ),
              )
            else if (purchaseService.isPurchasing)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(themeManager.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.processing,
                      style: TextStyle(color: themeManager.primaryColor),
                    ),
                  ],
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  purchaseService.buyProVersion();
                },
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: Text(
                  proProduct != null 
                      ? '${l10n.buyFor} ${proProduct.price}'
                      : l10n.buyProVersion,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            TextButton(
              onPressed: () {
                purchaseService.restorePurchases();
              },
              child: Text(
                l10n.restorePurchases,
                style: TextStyle(
                  color: themeManager.primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureItem(IconData icon, String text, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: themeManager.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProBadge extends StatelessWidget {
  const ProBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseService>(
      builder: (context, purchaseService, child) {
        if (!purchaseService.isProVersion) return const SizedBox.shrink();
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.amber, Colors.orange],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'PRO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
