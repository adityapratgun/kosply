/// Model data produk. Karena tugas ini fokus ke UI slicing + state
/// management, gambar produk tidak pakai file asli - digantikan ikon
/// placeholder (lihat [ProductImagePlaceholder] di widgets/product_card.dart),
/// persis seperti wireframe di desain Figma-nya.
class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final int quantity;
  final String category;
  final String sellerName;
  final String sellerStatus;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.category,
    required this.sellerName,
    required this.sellerStatus,
  });
}

/// Sekelompok produk dengan judul section (sesuai "Section title" di Home).
class ProductSection {
  final String title;
  final List<Product> products;

  const ProductSection({required this.title, required this.products});
}
