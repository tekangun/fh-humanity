import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 10.0, // distance between rows
                        spacing: 20.0, // distance between chips
                        children: [
                          Text(
                            'Havamızı Kirleten Maddeler ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                            'PM10-PM-2.5: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              'Toz, polen, küf gibi 10 mikron ve daha küçük parçacıklar PM10 (partiküler madde) olarak ve yanma sonucu oluşan parçacıkları, organik bileşikler gibi 2,5 mikron ve daha küçük parçacıklar ise PM2.5 olarak adlandırılır.'),
                          Text(
                            'PM10-PM-2.5 Zararları: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              'Akciğerler tarafından en derin noktalara kadar solunabilecek olan küçük partiküller PM10 ve PM2.5 olarak adlandırılırlar. Bunlardan daha iri olan partiküller ise üst solunum yollarında filtre edileceklerdir. PM2.5 bunların en tehlikelisi olup, bronkiollerin çevresel bölgelerinin en derin noktalarına kadar solunabilmekte ve akciğerler içersinde gaz değişimine etki edebilmektedirler.'
                              'Kalp ve damar hastalıkları özellikle de koroner kalp hastalığı tüm dünyada önde gelen ölüm nedenlerindendir. Kalp ve damar hastalıklarının en önemli 3 temel nedeni, yüksek kolesterol, yüksek tansiyon ve sigara kullanımıdır. Bu nedenle kolesterol ve hipertansiyonu normal seviyelerde tutmak amacıyla doktorlar tarafından sağlıklı beslenme, hareketli bir yaşam tarzı ve sigaradan uzak durulması önerilir. Bununla birlikte son dönemde yapılan tıbbi çalışmalar kalp ve damar hastalıklarının hava kirliliği, özellikle de ince partikül (PM2.5) kirliliği ile ilişkili olduğunu göstermiştir.'),
                          Text(
                            'CO: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              'Karbonmonoksit (CO) renksiz, kokusuz ve tatsızdır. Gaz, yağ, tahta ve kömür içeren karbon bazlı yakıtların eksik yanmasıyla meydana gelen zehirli bir gazdır. Fazla CO nun meydana geldiği yakıt düzgün bir biçimde yanmadığında tehlikeli olmaktadır.'),
                          Text(
                            'CO Zararları: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              'Baş ağırısı, Kusma, Nefes nefese kalma, Düşme, Baş dönmesi ve Bayılma'),
                          Text(
                            'Hava Kirliliğini Önlemek İçin Neler Yapılmalı?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                              '•	Bu kirliliklerle mücadelede bilinçli bireyler yetiştirilmelidir. Özellikle çocukların bu konuda duyarlı olmalarını sağlamak gelecek neslin bu konular üzerine daha etkin çözümler üretmeleri açısından önemlidir.'),
                          Text(
                              '•	Evleri ısıtmak amacıyla kullanılan kömürlerin düşük kalorili olmasına dikkat edilmeli ve yeni yapılacak binalarda da merkezi ısıtma tercih edilmelidir.'),
                          Text(
                              '•	Sobalı evlerde de düzenli olarak baca temizliği yapılmalıdır.'),
                          Text(
                              '•	Özel araç kullanımı azaltılmalı ve araçlardan çıkan egzoz gazı içinde filtre kullanımı zorunlu hale getirilmelidir.'),
                          Text(
                              '•	Sanayi yerleşimleri mümkün olduğunca konutlardan uzak yerlere kurulmalıdır.'),
                          Text(
                              '•	Fabrika bacalarında filtre kullanılmalı, yakıt olarak da doğal gaz tercih edilmelidir.'),
                          Text(
                              '•	Hava kirliliği ile mücadelede yeşil alanların artması büyük önem taşımaktadır. Bu sebeple ağaç dikimi yaygınlaştırılmalı ve yeşil alanların yok edilmesinden kaçınılmalıdır.'),
                          Text(
                              '•	Hava kirliliği nedenleri ve sonuçları doğrudan insanlar ile ilgilidir. Çünkü bu kirliliğe insanların değişen yaşamları neden olurken ortaya çıkacak olumsuz koşullardan da yine insan sağlığı etkilenecektir. Bu unutulmamalı ve geleceğimiz için gerekli önlemler alınmalıdır.'),
                          Text(
                            'Daha temiz bir dünyada yaşamak bizim ellerimizde temiz hava solumak, gerçek bir nefes almak istiyorsak birlikte gerekli önlemleri alıp harekete geçmeliyiz.\nGelecek bizim ellerimizde, daha temiz bir yaşam için koruyalım.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
