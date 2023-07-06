import 'package:flutter/material.dart';
import 'package:klinikapp/service/pegawai_service.dart';
import '../model/pegawai.dart';
import '../ui/pegawai_detail.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNip(),
              _fieldNamaPegawai(),
              _fieldtanggal_lahir(),
              _fieldnomor_telepon(),
              _fieldemail(),
              _fieldpassword(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNip() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nip"),
      controller: _nipCtrl,
    );
  }

  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }

  _fieldtanggal_lahir() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggal_lahirCtrl,
    );
  }

  _fieldnomor_telepon() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomor_teleponCtrl,
    );
  }

  _fieldemail() {
    return TextField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
    );
  }

  _fieldpassword() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pegawai pegawai = new Pegawai(
              nip: _nipCtrl.text,
              namaPegawai: _namaPegawaiCtrl.text,
              tanggalLahir: _tanggal_lahirCtrl.text,
              nomorTelepon: _nomor_teleponCtrl.text,
              email: _emailCtrl.text,
              password: _passwordCtrl.text);
          await PegawaiService().simpan(pegawai).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PegawaiDetail(pegawai: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
