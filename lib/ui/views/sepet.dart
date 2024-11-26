import 'package:eticaret_bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../themes/renkler.dart';
// Burada Sepet ekranı oluşuyor kullanıcı sepetteki ürünleri görebilir
// Ürün miktarlarını düzenleyebilir,silebilir ve toplam tutarı görebilir
class Sepet extends StatelessWidget {
  const Sepet({super.key});

  @override
  Widget build(BuildContext context) {
    String formatFiyat(int fiyat) { //Fiyatlandırma görselliği için kütüphane kullandık
      final formatter = NumberFormat.currency(
        locale: 'tr_TR',
        symbol: '₺',
        decimalDigits: 0, //Kusurat, kuruş
      );
      return formatter.format(fiyat);
    }
    context.read<SepetSayfaCubit>().sepetGetir("yusuferens");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sepetiniz",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: BlocBuilder<SepetSayfaCubit, SepetState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.sepetUrunler.isEmpty) {
            return const Center(
              child: Text("Sepetiniz Boş!", style: TextStyle(fontSize: 16)),
            );
          }

          int toplamTutar = 0;
          for (var urun in state.sepetUrunler) {
            toplamTutar += urun.fiyat * urun.siparisAdeti;
          }

          return Column(
            children: [
              // Sepet ürünlerinin listesi
              Expanded(
                child: ListView.builder(
                  itemCount: state.sepetUrunler.length,
                  itemBuilder: (context, index) {
                    var urun = state.sepetUrunler[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Image.network(
                          'http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(urun.ad, style: const TextStyle(fontSize: 16)),
                        subtitle: Text('${formatFiyat(urun.fiyat)} x ${urun.siparisAdeti}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                // .ekle fonksiyonu buraya da uygulanacak
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context.read<SepetSayfaCubit>().urunAzalt("yusuferens", urun.sepetId);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<SepetSayfaCubit>().urunSil("yusuferens", urun.ad);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Toplam tutar ve onay butonu
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: kartArkaplan1,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Toplam Tutar : ${formatFiyat(toplamTutar.toInt())} ",
                      style: const TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Sepeti Onayla işlevi
                      },
                      child: const Text(
                        "Sepeti Onayla",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

