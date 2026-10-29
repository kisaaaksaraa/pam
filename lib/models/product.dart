class Product {
  final String name;
  final String category; // Living Room / Bedroom / Dining Room
  final String image; // path asset
  final String priceUsd; // teks kecil abu-abu di kartu Home
  final int priceIdr; // harga yang tampil di halaman Pesan

  const Product({
    required this.name,
    required this.category,
    required this.image,
    required this.priceUsd,
    required this.priceIdr,
  });
}

/// 250000 -> "Rp.250.000,00"
String formatRupiah(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp.$buf,00';
}
