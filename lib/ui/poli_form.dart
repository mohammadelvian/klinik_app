import 'package:flutter/material.dart';
import 'package:klinikapp/model/poli.dart';
import 'package:klinikapp/service/poli_service.dart';
import 'package:klinikapp/ui/poli_detail.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNamaPoli(), SizedBox(height: 20), _tombolSimpan()],

            // Statement sebelum diubah...
            // TextField(
            //     decoration: const InputDecoration(labelText: "Nama Poli")),
            // SizedBox(height: 0),
            // ElevatedButton(onPressed: () {}, child: const Text("Simpan"))
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _namaPoliCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Poli poli = new Poli(namaPoli: _namaPoliCtrl.text);
          await PoliService().simpan(poli).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PoliDetail(poli: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
