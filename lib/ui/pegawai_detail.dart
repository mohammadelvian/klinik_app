import 'package:flutter/material.dart';
import 'package:klinikapp/service/pegawai_service.dart';
import 'pegawai_page.dart';
import '../model/pegawai.dart';
import 'pegawai_update_form.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiDetailState createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  Stream<Pegawai> getData() async* {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pegawai")),
      body: StreamBuilder(
        //mengambil detail pegawai dari API
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Nip : ${snapshot.data.nip}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Nama Pegawai : ${snapshot.data.namaPegawai}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Tanggal Lahir : ${snapshot.data.tanggalLahir}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Nomor Telepon : ${snapshot.data.nomorTelepon}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Email : ${snapshot.data.email}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Password : ${snapshot.data.password}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(), _tombolHapus()],
              )
            ],
          );
        },
      ),
      // Column(
      //   children: [
      //     SizedBox(height: 20),
      //     Text(
      //       "Nomor Induk Pegawai : ${widget.pegawai.nip}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     Text(
      //       "Nama Pegawai : ${widget.pegawai.namaPegawai}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     Text(
      //       "Tanggal Lahir : ${widget.pegawai.tanggalLahir}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     Text(
      //       "Nomor Telepon : ${widget.pegawai.nomorTelepon}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     Text(
      //       "E-mail : ${widget.pegawai.email}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     Text(
      //       "Password : ${widget.pegawai.password}",
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     SizedBox(height: 20),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         _tombolUbah(),
      //         _tombolHapus(),
      //         // ElevatedButton(
      //         //     onPressed: () {},
      //         //     style:
      //         //         ElevatedButton.styleFrom(backgroundColor: Colors.green),
      //         //     child: const Text("Ubah")),
      //         // ElevatedButton(
      //         //     onPressed: () {},
      //         //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      //         //     child: const Text("Hapus")),
      //       ],
      //     )
      //   ],
      // ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, //mengkoneksikan tombol  ubah dengan pegawai update form/form ubah pegawai
                  MaterialPageRoute(
                      builder: (context) =>
                          PegawaiUpdateForm(pegawai: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: const Text("Ubah")));

    // ElevatedButton(
    //     onPressed: () {
    //       Navigator.push(
    //           context, //mengkoneksikan tombol  ubah dengan pegawai update form/form ubah pegawai
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   PegawaiUpdateForm(pegawai: widget.pegawai)));
    //     },
    //     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
    //child: const Text("Ubah"));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              //tombol ya
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await PegawaiService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PegawaiPage()));
                          });
                        },
                        child: const Text("YA"),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      )),
              //Tombol batal
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tidak"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        child: const Text("Hapus"));
  }
}
