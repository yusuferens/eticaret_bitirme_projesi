import 'package:eticaret_bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit<void>{
  //veri taşıyan bir state kullanmadığımız için void kullandık
  DetaySayfaCubit():super(0);
  //başlangıçta verimiz yok

  var urepo = UrunlerDaoRepository();

  Future<void> ekle(String ad, String resim, String kategori, int fiyat, String marka, int siparisAdeti, String kullaniciAdi) async {
    // Ekleme yaparken siparisAdetimiz sepet işlemlerinde hata yarattığı için for döngüsüyle belirttiğimiz sipariş adetine gelene kadar yeni transactionlar üretiyor
    for(var i=0; i<siparisAdeti; i++){

      await urepo.ekle(ad, resim, kategori, fiyat, marka, 1, kullaniciAdi);
    }
    //ekle fonksiyonunu çağırıyoruz ve HTTP isteği yapıyor
    emit(true);
    //  ürünün sepede eklendiğine dair geri dönüş
    // UI kısmında BlocBuilder true durumunu kontrol edip kullanıcıya mesaj gösterebilir

  }

}