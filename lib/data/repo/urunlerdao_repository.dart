import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler_cevap.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler_sepeti.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler_sepeti_cevap.dart';
// Bu sınıf HTTP istekleri yaparak sunucudan veri alır veya gönderir
//API yanıtlarını işleyerek uygulama içinde kullanılabilir hale getirir

class UrunlerDaoRepository {

  // tumUrunleriGetir.php API'sinden dönen JSON verisini Urunler sınıfındaki modellere dönüştürüyor
  List<Urunler> parseUrunlerCevap(String cevap) {
    return UrunlerCevap.fromJson(json.decode(cevap)).urunler;
    // liste formatında Urunler nesneleri döndürüyoruz
  }

  // aynı şekilde UrunlerSepeti sınıfındaki modelleri döndürüyoruz
  List<UrunlerSepeti> parseUrunlerSepetiCevap(String cevap) {
    // Sepetin boş olma durumunda çalışacak hata yönetimi
    //
    if (cevap.isEmpty) {
      //cevap boş olduğunda da boş bir liste döndürüyoruz
      return [];
    }
    try {
      return UrunlerSepetiCevap.fromJson(json.decode(cevap)).urunlerSepeti;
    } catch (e) {
      print('hata $e');
      // hata alındığında boş liste döndürmek
      return [];
    }
  }

  // Sunucudan bütün ürünleri almak
  // GET isteği gönderiliyor
  // Future<List<Urunler>> dönüyor
  Future<List<Urunler>> urunleriYukle() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php");
    var cevap = await http.get(url);
    return parseUrunlerCevap(cevap.body);
  }

  // POST isteğiyle kullanıcı sepetine ürün eklemek
  // hiçbir şey döndürmediği için void kullanılıyor
  Future<void> ekle(String ad, String resim, String kategori, int fiyat, String marka, int siparisAdeti, String kullaniciAdi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php");

    var veri = {
      "ad": ad,
      "resim": resim,
      "kategori": kategori,
      "fiyat": fiyat.toString(),
      "marka": marka,
      "siparisAdeti": siparisAdeti.toString(),
      "kullaniciAdi": kullaniciAdi
    };

    var cevap = await http.post(url, body: veri);
    print(cevap.body);
  }

  // POST  isteği kullanılarak kullaniciAdi ile sunucudan sepet içeriğini getirme
  Future<List<UrunlerSepeti>> sepetGetir(String kullaniciAdi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php");
    var veri = {'kullaniciAdi': kullaniciAdi};
    var cevap = await http.post(url, body: veri);

    print(cevap.body);

    if (cevap.body.isEmpty) {
      //Yanıt boşsa boş bir liste döner
      return [];

    }

    return parseUrunlerSepetiCevap(cevap.body);
  }

  // POST isteği kullanılarak kullaniciAdi ve sepetId verileri ile sepetten ürün silmek
  //hiçbir şeyt döndürmez void
  Future<void> urunSil(String kullaniciAdi, int sepetId) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php");
    var veri = {
      "kullaniciAdi": kullaniciAdi,
      "sepetId": sepetId.toString()  // Ensure sepetId is a string when sending in the body
    };
    var cevap = await http.post(url, body: veri);
    print(cevap.body);  // Debugging output
  }


}
