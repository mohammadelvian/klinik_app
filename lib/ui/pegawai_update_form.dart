import 'package:flutter/material.dart';
import 'package:klinikapp/service/pegawai_service.dart';
import '../model/pegawai.dart';
import '../ui/pegawai_detail.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namapegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      _namapegawaiCtrl.text = data.namaPegawai;
      _nipCtrl.text = data.nip;
      _tanggal_lahirCtrl.text = data.tanggalLahir;
      _emailCtrl.text = data.email;
      _passwordCtrl.text = data.password;
      _nomor_teleponCtrl.text = data.nomorTelepon;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
    // {
    //   _namapegawaiCtrl.text = widget.pegawai.namaPegawai;
    //   _nipCtrl.text = widget.pegawai.nip;
    //   _tanggal_lahirCtrl.text = widget.pegawai.tanggalLahir;
    //   _nomor_teleponCtrl.text = widget.pegawai.nomorTelepon;
    //   _emailCtrl.text = widget.pegawai.email;
    //   _passwordCtrl.text = widget.pegawai.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah pegawai")),
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

  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama pegawai"),
      controller: _namapegawaiCtrl,
    );
  }

  _fieldNip() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nip"),
      controller: _nipCtrl,
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
              namaPegawai: _namapegawaiCtrl.text,
              nip: _nipCtrl.text,
              tanggalLahir: _tanggal_lahirCtrl.text,
              nomorTelepon: _nomor_teleponCtrl.text,
              email: _emailCtrl.text,
              password: _passwordCtrl.text);
          String id = widget.pegawai.id.toString();
          await PegawaiService().ubah(pegawai, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PegawaiDetail(pegawai: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
