import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';
import 'package:eticaret_bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Urunler>> {
  AnasayfaCubit() :super(<Urunler>[]);
  //başlangıçta boş bir Urunler listesi veriyor
  //sonrasında emit ile listeyi UI ya aktarmaya hazır hale getiriyor

  // bu değişken UrunlerDaoRepository sınıfına referans oluşturup
  // API çağrılarını gerçekleştirip Ürünleri sunucudan alıyor
  var urepo = UrunlerDaoRepository();

  Future<void> urunleriYukle() async {
    // ürünleri sunucudan alma işlemi asenkron işlemdir
    //  çünkü işlem tamamlandığında UI güncellemesi istiyoruz
    // API'dan tüm ürünleri getirip UI kısmına emit ediyoruz
    // BlocBuilder değişikliği dinliyor ve UI güncelleniyor
    var liste = await urepo.urunleriYukle();
    emit(liste);
  }

}
