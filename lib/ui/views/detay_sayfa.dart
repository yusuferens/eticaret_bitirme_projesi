import 'package:eticaret_bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:eticaret_bitirme_projesi/themes/renkler.dart';
import 'package:eticaret_bitirme_projesi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Bu sayfada ürün detayları,miktar seçimi ve sepete ekleme işlemi gerçekleşiyor
//Sayfa bir StatefulWidget olarak tanımlanmış ver Urunler nesnesini alıyor

class DetaySayfa extends StatefulWidget {
  final Urunler urun;

  const DetaySayfa({Key? key, required this.urun}) : super(key: key);

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  // _DetaySayfaState DetaySayfa stful widgetı için değişken veriyi içinde tutuyor
  // bu sayfa için bu veri ürün miktarı
  int _quantity = 1; // başlangıç miktarı  1

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //BlocProvider ile DetaySayfaCubit e eriştik
      create: (_) => DetaySayfaCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.urun.urun_ad,
            style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network( //ürünün resmine sağlanılan veritabanından eriştik
              'http://kasimadalan.pe.hu/urunler/resimler/${widget.urun.resim}',
              width: double.infinity,
              height: 250,
              fit: BoxFit.fitHeight, //görsel orantılı olarak sığdırıldı
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.urun.urun_ad,
                style: const TextStyle(

                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mattis cursus erat sit amet varius. Phasellus facilisis vitae augue in dapibus. Suspendisse potenti. Proin luctus.',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    
                ),
              ),
            ),
            const Spacer(), // Container widgetını aşağıya itmek için kullandık
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
                color: kartArkaplan1,

              ),
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.urun.fiyat} TL',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() { //setState ile anlık olarak UI güncellenir
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$_quantity', // kullanıcının seçtiği miktar ekranda görüntülenir
                        style: const TextStyle(fontSize: 20, ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() { //setState ile anlık olarak UI güncellenir
                            _quantity++;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Seçilen miktar ile ürünü sepete ekledik
                          context.read<DetaySayfaCubit>().ekle(
                              widget.urun.urun_ad,
                              widget.urun.resim,
                              widget.urun.kategori,
                              widget.urun.fiyat,
                              widget.urun.marka,
                              _quantity, // seçilen miktar
                              "yusuferens"
                          );
                          ScaffoldMessenger.of(context).showSnackBar( // ürün sepete eklendi bildirimi için widget
                            const SnackBar(content: Text("Ürün sepetinize eklendi", style: TextStyle())),
                          );
                        },
                        child: const Text("Sepete Ekle", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

              ),

          ],
        ),
      ),
    );
  }
}
