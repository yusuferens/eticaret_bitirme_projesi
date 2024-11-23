import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';

class UrunlerCevap{
  // API'den dönen ürün bilgilerini ve başarı durumunu modelleyen sınıf
  List<Urunler> urunler;
  int success;

  UrunlerCevap({required this.urunler, required this.success});
  factory UrunlerCevap.fromJson(Map<String,dynamic> json){
    //JSON verisinden bir UrunlerCevap nesnesi oluşturduk
    var jsonArray = json["urunler"] as List;
    //urunler anahtarı bir dizi(List) içerir
    int success = json["success"] as int;
    var urunler = jsonArray.map((jsonUrunNesnesi) => Urunler.fromJson(jsonUrunNesnesi)).toList();
    //Her bir ürün nesnesini (jsonUrunNesnesi),
    //Urunler sınıfına dönüştürmek için Urunler.fromJson metodunu kullanır.
    return UrunlerCevap(urunler: urunler, success: success);
    // sonuç olarak bir UrunlerCevap nesnesi dönüyor
  }
}