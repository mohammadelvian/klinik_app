import 'package:flutter/material.dart';
import 'package:klinikapp/service/pegawai_service.dart';
import 'package:klinikapp/ui/pegawai_form.dart';
import 'package:klinikapp/ui/pegawai_item.dart';
import 'package:klinikapp/widget/sidebar.dart';
import '../model/pegawai.dart';
import 'pegawai_detail.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({Key? key}) : super(key: key);
  _PegawaiPageState createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  Stream<List<Pegawai>> getList() async* {
    List<Pegawai> data = await PegawaiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: const Text("Data Pegawai"),
          actions: [
            GestureDetector(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PegawaiForm()));
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: getList(),
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
                return Text('Data Kosong');
              }

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PegawaiItem(pegawai: snapshot.data[index]);
                },
              );
              // ListView(children: [
              //   PegawaiItem(
              //       pegawai: Pegawai(
              //     namaPegawai: "Mohammad Elvian",
              //     nip: "19210972",
              //     tanggalLahir: "06 November 2014",
              //     nomorTelepon: "089887171717",
              //     email: "mohammadelvian@gmail.com",
              //     password: "1234",
              //   )),
              //   PegawaiItem(
              //       pegawai: Pegawai(
              //     namaPegawai: "Luhur Pambudi",
              //     nip: "19210196",
              //     tanggalLahir: "07 Oktober 1993",
              //     nomorTelepon: "088212880109",
              //     email: "cihuybuseng@gmail.com",
              //     password: "1234",
              //   )),
              //   PegawaiItem(
              //       pegawai: Pegawai(
              //     namaPegawai: "Arif Supriyanto",
              //     nip: "19210659",
              //     tanggalLahir: "22 April 2002",
              //     nomorTelepon: "085777463413",
              //     email: "arifsupriyanto2002@gmail.com",
              //     password: "1234",
              //   )),
              //   PegawaiItem(
              //       pegawai: Pegawai(
              //     namaPegawai: "Asep Nur Rohman",
              //     nip: "19210489",
              //     tanggalLahir: "20 Juli 2023",
              //     nomorTelepon: "08123456789",
              //     email: "asepnr02@gmail.com",
              //     password: "1234",
              //   )),
              //   PegawaiItem(
              //       pegawai: Pegawai(
              //     namaPegawai: "Pretty LB Situmeang",
              //     nip: "19210802",
              //     tanggalLahir: "02 April 2015",
              //     nomorTelepon: "08123456789",
              //     email: "prettysitumeang9@gmail.com",
              //     password: "1234",
              //   )),
              //   // GestureDetector(
              //     child: const Card(
              //       child: ListTile(
              //         title: Text("Mohammad Elvian"),
              //       ),
              //     ),
              //     onTap: () {
              //       Pegawai MohammadElvian = Pegawai(
              //         nip: "19210972",
              //         namaPegawai: "Mohammad Elvian",
              //         tanggalLahir: "11 November 2003",
              //         nomorTelepon: "089513958529",
              //         email: "19210972@bsi.ac.id",
              //         password: "12345",
              //       );
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //                 PegawaiDetail(pegawai: MohammadElvian),
              //           ));
              //     })
            }));
  }
}
