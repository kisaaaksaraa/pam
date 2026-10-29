import '../models/product.dart';

const List<String> categories = ['All', 'Living Room', 'Bedroom', 'Dining Room'];

// Harga bebas (diserahkan ke mahasiswa). Ganti nama file gambar sesuai yang disediakan.
const List<Product> products = [
  Product(
    name: 'Stylish Chair',
    category: 'Dining Room',
    image: 'assets/images/stylish_chair.jpg',
    priceUsd: '\$170',
    priceIdr: 175000,
  ),
  Product(
    name: 'Modern Table',
    category: 'Dining Room',
    image: 'assets/images/modern_table.jpeg',
    priceUsd: '\$75',
    priceIdr: 450000,
  ),
  Product(
    name: 'Wooden Console',
    category: 'Living Room',
    image: 'assets/images/wooden_console.jpg',
    priceUsd: '\$340',
    priceIdr: 250000,
  ),
  Product(
    name: 'Brown Armchair',
    category: 'Bedroom',
    image: 'assets/images/brown_armchair.jpeg',
    priceUsd: '\$210',
    priceIdr: 320000,
  ),
];
