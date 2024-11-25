# eticaret_bitirme_projesi

1. UI Katmanı (User Interface Layer)
   Uygulamanın kullanıcı arayüzü, Flutter widget'ları ile oluşturulmuştur. Bu katman, kullanıcının uygulama ile etkileşime girmesini sağlar. Temel işlevler:

Ürün Listeleme: Ürünler API'den çekilir ve kullanıcıya dinamik bir şekilde sunulur. Bu işlemde GridView ve ListView widget'ları kullanılır.
Ürün Detayı Görüntüleme: Kullanıcı bir ürüne tıkladığında, detay sayfasına yönlendirilir ve ürün hakkında daha fazla bilgi görüntülenir.
Sepet Yönetimi: Kullanıcılar sepete ürün ekleyebilir, çıkarabilir ve adetlerini değiştirebilirler.
Navigasyon: Sayfalar arası geçişler, kullanıcı etkileşimi ile yapılır (örneğin, ürün detayına gitmek veya sepete dönmek).
2. State Management (BLoC Pattern)
   Uygulama, BLoC (Business Logic Component) mimarisi kullanarak durum yönetimi yapmaktadır. BLoC, iş mantığı ve UI'yi birbirinden ayırır, böylece her ikisi de bağımsız bir şekilde geliştirilebilir ve test edilebilir.

Cubit: Flutter'daki Cubit sınıfı, state yönetimini sağlar. AnasayfaCubit, DetaySayfaCubit, ve SepetSayfaCubit gibi Cubit'ler, uygulamanın belirli bölümleri için ayrı ayrı durumları yönetir. Bu sayede her Cubit, yalnızca ilgili işlevsellikten sorumludur.
AnasayfaCubit: Ürünleri listeleyip UI'ye aktaran sınıftır.
DetaySayfaCubit: Ürün detaylarını işleyip sepete eklemeyi yönetir.
SepetSayfaCubit: Sepet içeriğini çeker, ürünleri grup halinde gösterir ve sepetin yönetimini sağlar.
3. Veri Katmanı (Data Layer)
   Veri katmanı, uygulamanın API'lerle iletişime geçmesini sağlar. Veriler HTTP istekleri ile alınır ve model sınıfları aracılığıyla işlenir.

API İletişimi: API'lere yapılan GET ve POST istekleri, ürünleri listelemek, sepeti çekmek, ürün eklemek ve silmek için kullanılır.
JSON Parsing: API'den gelen yanıtlar JSON formatında gelir ve bu veriler, model sınıflarına (Urunler, UrunlerSepeti, vb.) dönüştürülür. Bu sayede veriler, Flutter uygulamasında daha kolay kullanılabilir hale gelir.
UrunlerDaoRepository: Bu sınıf, veri ile ilgili işlemleri yürütür. API'ye yapılan istekler burada yönetilir. Örneğin, ürünleri çekmek, sepete ürün eklemek gibi işlemler burada yapılır.
4. İşlevsel Yapı (Core Functionality)
   Uygulamanın temel işlevselliği şu şekilde çalışır:

5. Ürünleri Listeleme: Ana sayfa açıldığında, ürünler API'den çekilir ve UI'ye aktarılır. Bu işlem urunleriYukle() fonksiyonu ile yapılır.
Ürün Detayı Görüntüleme: Kullanıcı bir ürünün detayına tıkladığında, detay sayfasına yönlendirilir. Burada, ürün hakkında daha fazla bilgi görüntülenir ve kullanıcı ürünü sepete ekleyebilir.
Sepete Ürün Ekleme: Kullanıcı, ürün detay sayfasında adet seçimi yapar ve sepete ekler. Bu işlem, ekle() fonksiyonu ile API'ye gönderilir.
Sepet Görüntüleme ve Yönetim: Kullanıcı, sepet sayfasına giderek sepetteki ürünleri görüntüler, adetleri günceller veya ürünleri siler. Sepetteki ürünler API'den çekilir ve BLoC ile UI'ye aktarılır.
Sepetten Ürün Silme ve Adet Değiştirme: Kullanıcı sepetteki ürünü silmek veya adedini azaltmak istediğinde, bu istek API'ye gönderilir ve sepet güncellenir.

Uygulamanın Genel Akışı:
   Uygulama Başlangıcı:

Ana Sayfa: Kullanıcı uygulamayı açtığında, ana sayfada urunleriYukle() fonksiyonu çağrılır ve ürünler liste olarak gösterilir.
Ürün Detayına Gitme:

Kullanıcı bir ürüne tıkladığında, DetaySayfaCubit devreye girer. Ürün detayları gösterilir ve sepete ekleme işlemi yapılabilir.
Sepete Ürün Ekleme:

Kullanıcı, ürün detay sayfasındaki "Sepete Ekle" butonuna tıkladığında, ürün sepete eklenir. Bu işlem ekle() fonksiyonu ile yapılır.
Sepet Sayfası:

Kullanıcı sepete gittiğinde, SepetSayfaCubit sepet verilerini API'den çeker ve sepetteki ürünleri UI'ye aktarır. Burada, ürün adedi değiştirilebilir veya ürünler silinebilir.
Sonraki Adımlar:

Sepet ve ürün işlemleri API üzerinden yönetildiği için, kullanıcı eklemeler ve silmeler yaptıkça, veritabanı güncellenir ve UI'de değişiklikler gösterilir.
=======
Bitirme projem
>>>>>>> origin/master
