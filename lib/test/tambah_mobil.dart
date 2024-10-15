import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahMobil extends StatefulWidget {
  @override
  _TambahMobilState createState() => _TambahMobilState();
}

class _TambahMobilState extends State<TambahMobil> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _merkController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();

  final CollectionReference _mobilCollection =
      FirebaseFirestore.instance.collection('mobil');

  Future<void> _tambahMobil() async {
    if (_namaController.text.isNotEmpty &&
        _merkController.text.isNotEmpty &&
        _tahunController.text.isNotEmpty) {
      await _mobilCollection.add({
        'nama': _namaController.text,
        'merk': _merkController.text,
        'tahun': _tahunController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data mobil berhasil ditambahkan')),
      );

      _namaController.clear();
      _merkController.clear();
      _tahunController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Mobil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Mobil'),
            ),
            TextField(
              controller: _merkController,
              decoration: InputDecoration(labelText: 'Merk Mobil'),
            ),
            TextField(
              controller: _tahunController,
              decoration: InputDecoration(labelText: 'Tahun Mobil'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _tambahMobil,
              child: Text('Tambah Mobil'),
            ),
          ],
        ),
      ),
    );
  }
}
