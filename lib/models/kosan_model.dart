class KosanModel {
  String? nama_kosan;
  String? gambar_kosan;
  String? alamat_kosan;
  String? jangka_sewa;
  int? harga;
  String? deskripsi;

  KosanModel(
      {this.nama_kosan,
      this.gambar_kosan,
      this.alamat_kosan,
      this.jangka_sewa,
      this.harga,
      this.deskripsi});

  factory KosanModel.fromMap(map) {
    return KosanModel(
        nama_kosan: map['nama_kosan'],
        gambar_kosan: map['gambar_kosan'],
        alamat_kosan: map['alamat_kosan'],
        jangka_sewa: map['jangka_sewa'],
        harga: map['harga'],
        deskripsi: map['deskripsi']);
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_kosan': nama_kosan,
      'gambar_kosan': gambar_kosan,
      'alamat_kosan': alamat_kosan,
      'jangka_sewa': jangka_sewa,
      'harga': harga,
      'deskripsi': deskripsi
    };
  }
}
