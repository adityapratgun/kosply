import 'package:flutter/material.dart';

import '../data/dummy_products.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'favorite_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
    );
  }

  void _onNavTap(int index) {
    if (index == 0) {
      setState(() => _navIndex = index);
      return;
    }
    // Screen lain (Search, Jual, Inbox, Profil) di luar cakupan tugas ini.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur ini belum tersedia di demo tugas ini')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildBanner()),
            for (final section in productSections)
              SliverToBoxAdapter(child: _buildSection(section)),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.surface,
                child: Text('K', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text('ITB Ganesha, Ba...', overflow: TextOverflow.ellipsis),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: AppColors.primary),
                tooltip: 'Favorite',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const FavoriteScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: AppColors.primary),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Cari meja belajar, kipas, rice cooker...',
                    style: TextStyle(color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.mic, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Icon(Icons.tune, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 160,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: const [
          SizedBox(
            width: 260,
            child: ProductImagePlaceholder(borderRadius: 20),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: ProductImagePlaceholder(borderRadius: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(ProductSection section) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(section.title, style: Theme.of(context).textTheme.titleLarge),
              const Icon(Icons.arrow_forward),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
              height: 210,
              child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: section.products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = section.products[index];
                return ProductCard(
                  product: product,
                  onTap: () => _openProduct(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    const items = [
      (icon: Icons.home_rounded, label: 'Home'),
      (icon: Icons.search, label: 'Search'),
      (icon: Icons.storefront_outlined, label: 'Jual'),
      (icon: Icons.chat_bubble_outline, label: 'Inbox'),
      (icon: Icons.person_outline, label: 'Profil'),
    ];

    return BottomNavigationBar(
      currentIndex: _navIndex,
      onTap: _onNavTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      items: [
        for (final item in items)
          BottomNavigationBarItem(icon: Icon(item.icon), label: item.label),
      ],
    );
  }
}
