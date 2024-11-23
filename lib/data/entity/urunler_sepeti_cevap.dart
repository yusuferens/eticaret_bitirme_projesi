import 'package:eticaret_bitirme_projesi/data/entity/urunler_sepeti.dart';
// API'den dönen sepet ürün bilgilerini ve başarı durumunu modelleyen sınıf

class UrunlerSepetiCevap {
  List<UrunlerSepeti> urunlerSepeti;
  int success;

  UrunlerSepetiCevap({
    required this.urunlerSepeti,
    required this.success,
  });

  factory UrunlerSepetiCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['urunler_sepeti'] as List;
    int success = json['success'] as int;
    var urunler = jsonArray
        .map((jsonUrun) => UrunlerSepeti.fromJson(jsonUrun))
        .toList();
    return UrunlerSepetiCevap(urunlerSepeti: urunler, success: success);
  }
}
