import 'package:flutter/foundation.dart';
import '../pages/layanan_page.dart';

class PengajuanModel extends ChangeNotifier {
  final List<Layanan> _daftarPengajuan = [];

  List<Layanan> get daftarPengajuan => _daftarPengajuan;

  int get totalPengajuan => _daftarPengajuan.length;

  void tambahPengajuan(Layanan layanan) {
    _daftarPengajuan.add(layanan);
    notifyListeners();
  }
}