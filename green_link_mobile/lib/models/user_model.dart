class UserModel {
  final String id;
  final String nama;
  final String email;
  final String noHp;
  final String namaPeran;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.namaPeran,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nama: json['nama'],
      email: json['email'],
      noHp: json['no_hp'],
      namaPeran: json['nama_peran'] ?? 'User',
    );
  }
}