import 'package:digikos_mobile/models/kosan_model.dart';
import 'package:flutter/material.dart';

class KostDetail extends StatelessWidget {
  final KosanModel kost;
  const KostDetail({Key? key, required this.kost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Kost',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              kost.gambar_kosan!,
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                kost.nama_kosan!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Alamat: ${kost.alamat_kosan!}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Biaya kost Rp.${kost.harga}/${kost.jangka_sewa}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                kost.deskripsi!,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.3,
            ),
            Center(
                child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Order',
                    style: TextStyle(color: Colors.white),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
