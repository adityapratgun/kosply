import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import '../models/product.dart';
import '../providers/favorite_provider.dart';
import '../theme/app_theme.dart';
 
/// Placeholder gambar produk, meniru ikon segitiga+bintang+kotak pada
/// wireframe Figma (karena desainnya belum pakai foto asli).
class ProductImagePlaceholder extends StatelessWidget {
  const ProductImagePlaceholder({super.key, this.borderRadius = 16});
 
  final double borderRadius;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Center(
        child: Icon(
          Icons.change_history_rounded,
          size: 36,
          color: AppColors.placeholderIcon,
        ),
      ),
    );
  }
}
 
/// Kartu produk dengan tombol favorit (ikon hati) di pojok kanan atas
/// gambar. Dipakai di Home (list horizontal per section) & bisa dipakai
/// ulang di tempat lain.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width = 150,
  });
 
  final Product product;
  final VoidCallback onTap;
  final double width;
 
  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoriteProvider, bool>(
      (provider) => provider.isFavorite(product),
    );
 
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  const Positioned.fill(child: ProductImagePlaceholder()),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _FavoriteButton(
                      isFavorite: isFavorite,
                      onTap: () =>
                          context.read<FavoriteProvider>().toggleFavorite(product),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.price,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onTap});
 
  final bool isFavorite;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 16,
          color: isFavorite ? Colors.redAccent : AppColors.primary,
        ),
      ),
    );
  }
}