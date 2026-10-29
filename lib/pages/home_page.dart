import 'package:flutter/material.dart';
import '../data/products.dart';
import '../models/product.dart';
import '../widgets/app_bottom_bar.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  final String storeName;
  const HomePage({super.key, required this.storeName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  int _navIndex = 0;
  final Set<String> _favorites = {};

  List<Product> get _filtered => _selectedCategory == 'All'
      ? products
      : products.where((p) => p.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.menu),
        title: const Text('Home'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: _navIndex == 0
          ? _buildHome()
          : Center(
              child: Text(
                const ['Home', 'Search', 'Keranjang', 'Profil'][_navIndex],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }

  Widget _buildHome() {
    final items = _filtered;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(widget.storeName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((c) {
                final selected = c == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: selected,
                    showCheckmark: false,
                    selectedColor: Colors.black,
                    backgroundColor: Colors.grey.shade300,
                    labelStyle: TextStyle(
                        fontSize: 12, color: selected ? Colors.white : Colors.black87),
                    onSelected: (_) => setState(() => _selectedCategory = c),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (_, i) => _productCard(items[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(Product p) {
    final fav = _favorites.contains(p.name);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(product: p)),
      ),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  p.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(p.name,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(p.priceUsd,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, size: 10, color: Colors.orange),
                      Icon(Icons.star, size: 10, color: Colors.orange),
                      Icon(Icons.star, size: 10, color: Colors.orange),
                      Icon(Icons.star, size: 10, color: Colors.orange),
                      Icon(Icons.star, size: 10, color: Colors.orange),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 18,
                    onPressed: () => setState(() {
                      fav ? _favorites.remove(p.name) : _favorites.add(p.name);
                    }),
                    icon: Icon(fav ? Icons.favorite : Icons.favorite_border,
                        color: fav ? Colors.red : null),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
