import '../models/product.dart';

const _lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim '
    'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea '
    'commodo consequat.';

/// Data dummy, meniru contoh item pencarian di search bar Home:
/// "Cari meja belajar, kipas, rice cooker...".
final List<Product> dummyProducts = [
  const Product(
    id: 'p1',
    name: 'Meja Belajar Lipat',
    price: 'Rp150.000',
    description: _lorem,
    quantity: 10,
    category: 'Barang',
    sellerName: 'Rian Pratama',
    sellerStatus: 'Active 20 menit yg lalu',
  ),
  const Product(
    id: 'p2',
    name: 'Kipas Angin Mini',
    price: 'Rp85.000',
    description: _lorem,
    quantity: 25,
    category: 'Elektronik',
    sellerName: 'Sarah Amelia',
    sellerStatus: 'Online',
  ),
  const Product(
    id: 'p3',
    name: 'Rice Cooker Mini',
    price: 'Rp120.000',
    description: _lorem,
    quantity: 7,
    category: 'Elektronik',
    sellerName: 'Budi Santoso',
    sellerStatus: 'Active 2 jam yg lalu',
  ),
  const Product(
    id: 'p4',
    name: 'Rak Sepatu Susun 3',
    price: 'Rp95.000',
    description: _lorem,
    quantity: 15,
    category: 'Barang',
    sellerName: 'Dewi Lestari',
    sellerStatus: 'Active 5 menit yg lalu',
  ),
  const Product(
    id: 'p5',
    name: 'Sepatu Sneakers Bekas',
    price: 'Rp200.000',
    description: _lorem,
    quantity: 1,
    category: 'Fashion',
    sellerName: 'Andi Wijaya',
    sellerStatus: 'Online',
  ),
  const Product(
    id: 'p6',
    name: 'Lampu Belajar LED',
    price: 'Rp60.000',
    description: _lorem,
    quantity: 30,
    category: 'Elektronik',
    sellerName: 'Rian Pratama',
    sellerStatus: 'Active 20 menit yg lalu',
  ),
];

/// Dua section yang muncul berulang di Home ("Section title" pertama & kedua
/// pada desain).
final List<ProductSection> productSections = [
  ProductSection(title: 'Rekomendasi untukmu', products: dummyProducts),
  ProductSection(
    title: 'Barang Populer',
    products: dummyProducts.reversed.toList(),
  ),
];
