import 'package:eticaret_bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../themes/renkler.dart';
// Burada Sepet ekranı oluşuyor kullanıcı sepetteki ürünleri görebilir
// Ürün miktarlarını düzenleyebilir,silebilir ve toplam tutarı görebilir
class Sepet extends StatelessWidget {
  const Sepet({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SepetSayfaCubit>().sepetGetir("yusuferens");
    // Kullanıcıya ait (yusuferens) sepet verilerini SepetSayfaCubit kullanarak getirir
    // İşlem ekranın ilk yüklendiği anda gerçekleşiyor
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sepetiniz",
          style: TextStyle( fontSize: 24),
        ),
      ),
      body: BlocBuilder<SepetSayfaCubit, SepetState>(
        // SepetSayfaCubit durumu dinleniyor ve UI güncelleniyor
        builder: (context, state) {
          if (state.isLoading) {
            // veriler yüklenirken bir yüklenme göstergesi gösterilir
            return const Center(child: CircularProgressIndicator());
          }

          if (state.sepetUrunler.isEmpty) {
            return const Center(child: Text("Sepetiniz Boş!", style: TextStyle()));
          }

          // Her bir ürünün fiyatı, miktarla çarpılıp toplam tutar hesaplanır
          int toplamTutar = 0;
          for (var urun in state.sepetUrunler) {
            toplamTutar += urun.fiyat * urun.siparisAdeti;
          }

          return ListView.builder(
            //ListView.builder ile sepetteki ürünler listelenir
            itemCount: state.sepetUrunler.length,
            // state ifadesini sepetle ilgili güncel duruma erişmek için kullandık
            // Sepet güncellendiğinde de UI otomatik olarak güncellenecek
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
                  title: Text(urun.ad, style: const TextStyle( fontSize: 16)),
                  subtitle: Text('₺${urun.fiyat} x ${urun.siparisAdeti}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Şimdilik boş işlev
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (urun.siparisAdeti > 1) {
                            // Miktarı azaltıyor eğer miktar 1 den küçükse sepetten siliyor
                            context.read<SepetSayfaCubit>().urunAdetAzalt("yusuferens", urun.sepetId);
                          } else {
                            context.read<SepetSayfaCubit>().urunSil("yusuferens", urun.sepetId);
                          }
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {

                          context.read<SepetSayfaCubit>().urunSil("yusuferens", urun.sepetId);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // toplamTutar değeri bottomNavigationBar'a geçiyor
      bottomNavigationBar: BlocBuilder<SepetSayfaCubit, SepetState>(
        builder: (context, state) {
          int toplamTutar = 0;
          for (var urun in state.sepetUrunler) {
            toplamTutar += urun.fiyat * urun.siparisAdeti;
          }

          return Container(
              decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
               color: kartArkaplan1,
              ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Toplam Tutar : ${toplamTutar.toString()} TL",
                    style: const TextStyle(fontSize: 16,  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // boş işlev
                    },
                    child: const Text(
                      "Sepeti Onayla",
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
