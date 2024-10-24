import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Sudah benar, tapi tambahkan satu lagi
import 'package:url_launcher/url_launcher_string.dart'; // Untuk mendukung launchUrl() method

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['name'] = 'Angga (Aang)';
    biodata['email'] = 'angga@gmail.com';
    biodata['phone'] = '+6281283308005';
    biodata['image'] = 'galaksi.png';
    biodata['hobby'] = 'Badminton and Game Point Blank';
    biodata['addr'] = 'Jl.Sumatra';
    biodata['desc'] =
        '''Ini adalah contoh teks panjang yang menggunakan string multi-line untuk tampil dalam beberapa baris. ''';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Biodata",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Biodata")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            textKotak(Colors.black38, biodata['name'] ?? ''),
            Image(image: AssetImage('assets/${biodata["image"] ?? ''}')),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                btnContact(Icons.alternate_email, Colors.green[900],
                    "mailto:${biodata['email']}"),
                btnContact(Icons.mark_email_unread_rounded, Colors.blueAccent,
                    "https://wa.me/${biodata['phone']}"),
                btnContact(
                    Icons.phone, Colors.deepPurple, "tel:${biodata['phone']}"),
              ],
            ),
            const SizedBox(height: 10),
            textAttribute("Hobby", biodata['hobby'] ?? ''),
            textAttribute("Alamat", biodata['addr'] ?? ''),
            const SizedBox(height: 10),
            textKotak(Colors.black38, 'Deskripsi'),
            const SizedBox(height: 10),
            Text(
              biodata['desc'] ?? '',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ),
    );
  }

  Container textKotak(Color bgColor, String teks) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }

  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        SizedBox(
            width: 80,
            child: Text("- $judul",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20))),
        const Text(":", style: TextStyle(fontSize: 15)),
         Flexible(
          child: Text(teks, style: const TextStyle(fontSize: 15)),
        )
      ],
    );
  }

  Expanded btnContact(IconData icon, var color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launch(uri);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        child: Icon(icon),
      ),
    );
  }

  Future<void> launch(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat memangil: $uri');
    }
  }
}
