class Pegawai {
  String? id;
  String nip;
  String namaPegawai;
  String tanggalLahir;
  String nomorTelepon;
  String email;
  String password;

  Pegawai(
      {this.id,
      required this.nip,
      required this.namaPegawai,
      required this.tanggalLahir,
      required this.nomorTelepon,
      required this.email,
      required this.password});

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
      id: json["id"],
      nip: json["nip"],
      namaPegawai: json["namaPegawai"],
      tanggalLahir: json["tanggalLahir"],
      nomorTelepon: json["nomorTelepon"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "namaPegawai": namaPegawai,
        "tanggalLahir": tanggalLahir,
        "nomorTelepon": nomorTelepon,
        "email": email,
        "password": password,
      };
}
