import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticaret_bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler_sepeti.dart';

class SepetState {
  //Bu sınıf SepetSayfaCubit in durumunu(state) tanımlar
  final bool isLoading;
  final List<UrunlerSepeti> sepetUrunler;
  SepetState({required this.isLoading,required this.sepetUrunler});

}
class SepetSayfaCubit extends Cubit<SepetState> {

  SepetSayfaCubit() : super(SepetState(
      isLoading: true, sepetUrunler: [])); // Sepet başta boş ve yükleniyor tanımlandı

  var urepo = UrunlerDaoRepository();

  // Verilen kullanıcıya göre sepedi çekmek için HTTP isteği gönderir
  Future<void> sepetGetir(String kullaniciAdi) async {
    var liste = await urepo.sepetGetir(kullaniciAdi);

    // aynı 'ad' a sahip ürünleri gruplama
    Map<String, UrunlerSepeti> groupedItems = {};
    for (var urun in liste) {
      if (groupedItems.containsKey(urun.ad)) {
        // var olan ürünün sayısını arttırmak için döngümüz
        groupedItems[urun.ad]!.siparisAdeti += urun.siparisAdeti;
      } else {
        // ürünleri listeye ekledik. ad keyimiz oldu UrunleSepeti nesnesi de değerimiz
        groupedItems[urun.ad] = urun;
      }
    }

    // Map içindeki ürünler listeye dönüştürülür ve yeni bir SepetState ile emit edilir
    // bu şekilde günmcellenmiş UI verileri aktarılır
    emit(SepetState(
        isLoading: false,
        sepetUrunler: groupedItems.values.toList()));
  }

  //Sepetten ürün silme fonksiyonu
  Future<void> urunSil(String kullaniciAdi, int sepetId) async {
    await urepo.urunSil(kullaniciAdi, sepetId);
    await sepetGetir(kullaniciAdi); // silme işlemi ardından sepet yenileniyor
  }
  void urunAdetAzalt(String kullaniciAdi, int sepetId) async {
    // Sepetten ürün azaltma fonksiyonu
    var urun = state.sepetUrunler.firstWhere((item) => item.sepetId == sepetId);

    // Adeti azaltma
    if (urun.siparisAdeti > 1) {
      urun.siparisAdeti--;

      // Güncellenmiş sepet listesi emit edilir ve UI güncellenir
      emit(SepetState(
        isLoading: false,
        sepetUrunler: List.from(state.sepetUrunler),
      ));


    }
  }




}