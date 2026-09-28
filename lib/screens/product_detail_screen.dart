import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import '../data/dummy_products.dart';
import '../models/product.dart';
import '../providers/favorite_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
 
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
 
  final Product product;
 
  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoriteProvider, bool>(
      (provider) => provider.isFavorite(product),
    );
 
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar sederhana (pinned) supaya tombol Back/Bookmark tetap
          // terlihat saat scroll. Gambar utama dipindah ke body agar sudutnya
          // membulat penuh seperti di Figma.
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.scaffoldBackground,
            foregroundColor: AppColors.textPrimary,
            leading: const BackButton(),
            title: const Text('Back'),
            actions: [
              IconButton(
                icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () =>
                    context.read<FavoriteProvider>().toggleFavorite(product),
              ),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: ProductImagePlaceholder(borderRadius: 20),
                  ),
                  const SizedBox(height: 12),
                  _buildThumbnails(),
                  const SizedBox(height: 16),
                  _buildTitleAndChat(context),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(product.description),
                  const Divider(height: 32),
                  _buildInfoRow('Quantitas', '${product.quantity}'),
                  const Divider(height: 32),
                  _buildInfoRow('Category', product.category),
                  const Divider(height: 32),
                  _buildSellerInfo(),
                  const SizedBox(height: 24),
                  _buildRecentlyViewed(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildThumbnails() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => const SizedBox(
          width: 90,
          child: ProductImagePlaceholder(borderRadius: 12),
        ),
      ),
    );
  }
 
  Widget _buildTitleAndChat(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sebelumnya hardcode 'Title'; sekarang pakai nama produk asli.
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              Text(
                product.price,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Membuka chat dengan ${product.sellerName}')),
            );
          },
          child: const Text('Chat seller'),
        ),
      ],
    );
  }
 
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
 
  Widget _buildSellerInfo() {
    return Row(
      children: [
        const CircleAvatar(radius: 22, backgroundColor: AppColors.surface),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.sellerName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppColors.online),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      product.sellerStatus,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.online,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _buildRecentlyViewed(BuildContext context) {
    final others =
        dummyProducts.where((p) => p.id != product.id).take(4).toList();
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Icon(Icons.history, size: 18),
                SizedBox(width: 6),
                Text(
                  'Produk yang Baru Dilihat',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('Lihat semua', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 12),
        // Tinggi 210 (bukan 190) supaya ProductCard tidak overflow.
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: others.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final other = others[index];
              return ProductCard(
                product: other,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: other),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
