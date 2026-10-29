import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../models/product.dart';
import '../widgets/app_bottom_bar.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  Future<void> _orderViaWhatsApp(BuildContext context) async {
    final text = 'Halo, saya ingin memesan ${product.name} '
        'seharga ${formatRupiah(product.priceIdr)}';
    final uri = Uri.parse(
        'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(text)}');
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) _error(context);
    } catch (_) {
      if (context.mounted) _error(context);
    }
  }

  void _error(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
      );

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFD50000);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pesan'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none))],
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: red),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported, size: 48)),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                formatRupiah(product.priceIdr),
                style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: red),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Material(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () => _orderViaWhatsApp(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/whatsapp.png',
                          width: 30,
                          height: 30,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.chat, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order via WhatsApp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            Text('Klik di Sini!',
                                style: TextStyle(color: Colors.white, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: 0,
        onTap: (_) => Navigator.pop(context),
      ),
    );
  }
}
