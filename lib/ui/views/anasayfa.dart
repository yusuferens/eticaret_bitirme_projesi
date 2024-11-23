import 'package:eticaret_bitirme_projesi/themes/renkler.dart';
import 'package:eticaret_bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:eticaret_bitirme_projesi/data/entity/urunler.dart';
import 'package:eticaret_bitirme_projesi/ui/views/detay_sayfa.dart';
import 'package:eticaret_bitirme_projesi/ui/views/kategori_sayfa.dart';
import 'package:eticaret_bitirme_projesi/ui/views/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

//main.dart dosyasındaki MultiBlocProvider ile Cubit'leri başlatıyoruz.
//UrunlerDaoRepository sınıfı API ile etkileşimi kuruyor
// AnasayfaCubit’i sayfaya sağlıyoruz, böylece ürünler API'den çekilmeye başlar.
//Kullanıcı Anasayfa sayfasına geldiğinde, initState() içinde AnasayfaCubit'i kullanarak tüm ürünler API'den çekilir.
//urunleriYukle metodu API den tüm ürünleri çekiyor json verisi Urunler Modeline dönüşüyor
// gridView içinde de bütün ürünler görüntüleniyor
class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().urunleriYukle();
  }
 //tüm ürünlerle yukarı çıkacak
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kartArkaplan1,
        title: const Text("JoStore",style: TextStyle(fontFamily:'OpenSans',fontSize: 24,fontWeight: FontWeight.bold ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {


            },
          ),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Urunler>>(
        builder: (context, urunler) {
          if (urunler.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView( //bütün sayfayı scrollable yapıyor
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ClipRRect(// Çocuğunu yuvarlatılmış bir dikdörtgen kullanarak kesmeye yarayan bir widget.
                    borderRadius: BorderRadius.circular(20.0),
                    child: CarouselSlider(
                      items: [
                        Container(
                          child:  Image.asset('assets/images/promo1.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,), //mümkün olduğu kadar genişletme

                        ),
                        Container(
                          child: Image.asset('assets/images/promo1.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,),
                        ),
                        Container(
                          child: Image.asset('assets/images/promo1.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 150.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1, // sadece bir adet öğe gösteriyor
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // widgetlar arası boşluk yaratmak için
                  const Text(
                    "Kategoriler",
                    style: TextStyle(fontSize: 22, fontFamily:'OpenSans'),
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider(  // Kategori sayfamıza erişmek için Widget
                    items:  [
                      GestureDetector( // GestureDetector widgetı ile Card widgetlarına onTap özelliği ekledik
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KategoriSayfa(kategori: "Teknoloji"), // Kategori ismini geçirdik
                            ),
                          );
                        },
                        child: Card(
                          color: kartArkaplan2,
                          child: const Center(child: Text("Teknoloji", style: TextStyle())),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KategoriSayfa(kategori: "Aksesuar"), //  Kategori ismini geçirdik
                            ),
                          );
                        },
                        child:  Card(
                          color: kartArkaplan3,
                          child: const Center(child: Text("Aksesuar", style: TextStyle())),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KategoriSayfa(kategori: "Kozmetik"), //  Kategori ismini geçirdik
                            ),
                          );
                        },
                        child:  Card(
                          color: kartArkaplan4,
                          child: Center(child: Text("Kozmetik", style: TextStyle())),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 100.0,
                      autoPlay: false,
                      enlargeCenterPage: false,
                      viewportFraction: 0.30,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text("Tüm Ürünler", style: TextStyle(fontSize: 22, )),
                  GridView.builder( // GridView.builder ile tüm ürünleri grid yapısında dizdik
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.3 / 1.7,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: urunler.length,
                    shrinkWrap: true, // GridView içeriği kadar yer kaplıyor
                    physics: const NeverScrollableScrollPhysics(), // kaydırmayı kapatıyor bu widget için
                    itemBuilder: (context, index) {
                      final urun = urunler[index];
                      final imageUrl = 'http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}';

                      return GestureDetector( //DetaySayfa'mıza erişmek için tekrardan onTap özelliği ekledik
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DetaySayfa(urun: urun),
                          ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  urun.urun_ad,
                                  style: const TextStyle(

                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${urun.fiyat} TL',
                                  style: const TextStyle(

                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sepet()), // Sepet sayfamıza erişeceğimiz widget
          );
        },
        backgroundColor: kartArkaplan3,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // sağ alt kısma koymamızı sağladık
    );
  }
}
