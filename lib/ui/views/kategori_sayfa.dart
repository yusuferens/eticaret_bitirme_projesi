import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticaret_bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';

import 'detay_sayfa.dart';
// Seçili kategoriye ait ürünleri filtreleyerek ekrana listeliyor
// ayrıca kullanıcı bir ürüne tıkladığında ürün detay sayfasına yönlendiriliyor

class KategoriSayfa extends StatelessWidget {
  final String kategori;  // anasayfadan kategori parametresini alıyor

  // Kategoriye ihtiyacı olan Constructor sınıfımız
  const KategoriSayfa({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {

    context.read<AnasayfaCubit>().urunleriYukle();  // Tüm ürünleri getiriyoruz

    return Scaffold(
      appBar: AppBar(
        title: Text("Seçili Kategori: $kategori"), // Seçili kategori ismi
      ),
      body: BlocBuilder<AnasayfaCubit, List<Urunler>>(
        // Uygulama başlatıldığında tüm ürünler AnasayfaCubit üzerinden yüklenir.
        // Sayfaya tüm ürünler getiriliyor ve sayfada kategoriye göre filtreleniyor
        builder: (context, urunler) {
          final kategoriUrunler = urunler.where((urun) => urun.kategori == kategori).toList();
          // eğer bir ürünün kategorisi seçilen kategoriye eşitse filtrelenen listeye dahil ediliyor
          // where fonksiyonu iterable döndürüyor to.List ile bu iterable'ı listeye dönüştürdük
          // sonuç olarakta sadece seçilen kategoriye ait ürünleri içeren bir liste oluşuyor
          if (kategoriUrunler.isEmpty) {
            return const Center(child: Text("Bu kategoride ürün bulunmamaktadır."));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.3 / 1.7,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: kategoriUrunler.length,
            itemBuilder: (context, index) {
              final urun = kategoriUrunler[index];
              final imageUrl = 'http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}';

              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetaySayfa(urun: urun),
                    ),
                  );
                  // Kullanıcı ürüne tıklayınca tekrardan detay sayfasına yönleniyor
                  // seçilen ürün bilgisi urun parametresiyle gönderiliyor

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          urun.urun_ad,
                          style: const TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${urun.fiyat} TL',
                          style: const TextStyle(

                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
