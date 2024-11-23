// Bu sınıf Urunler adlı veri modelini temsil ediyor ve ürünler ile ilgili bilgileri saklar
// API'den JSON foırmatında gelen ürün verisini Urunler.fromJson ile nesneye dönüştürdük
// bu şekilde UI'da kullanımını sağladık
class Urunler {
  int urun_id;
  String urun_ad;
  String resim;
  String kategori;
  int fiyat;
  String marka;

  Urunler(
      //nesne oluşturulurken sağlanması gereken alanlar
      {required this.urun_id,
      required this.urun_ad,
      required this.resim,
      required this.kategori,
      required this.fiyat,
        required this.marka,
  });
  factory Urunler.fromJson(Map<String,dynamic> json){
    //JSON formatındaki verileri Urunler nesnesine dönüştürmek için kullanılıyor
    return Urunler(urun_id: json['id'],
        urun_ad: json['ad'],
        resim: json['resim'],
        kategori: json['kategori'],
        fiyat: json['fiyat'],
        marka: json['marka'],
    );
  }
    // Nesne özelliklerine sabit değer atadık sepet işlemleri için
  int get sepetId => 1;

  get siparisAdeti => 1;



}