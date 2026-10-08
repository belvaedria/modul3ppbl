import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class Layanan {
  final String nama;
  final String dinas;
  final String jamOperasional;
  final String keterangan;

  const Layanan({
    required this.nama,
    required this.dinas,
    required this.jamOperasional,
    required this.keterangan,
  });
}

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  static const List<Layanan> perizinan = [
    Layanan(
      nama: 'Izin Usaha',
      dinas:
          'Dinas Penanaman Modal dan Pelayanan Terpadu',
      jamOperasional: '08.00 - 15.00',
      keterangan:
          'Layanan pengajuan izin usaha bagi masyarakat dan pelaku UMKM.',
    ),
    Layanan(
      nama: 'Izin Bangunan',
      dinas:
          'Dinas Pekerjaan Umum dan Tata Ruang',
      jamOperasional: '08.00 - 15.00',
      keterangan:
          'Layanan pengurusan perizinan pembangunan dan bangunan.',
    ),
    Layanan(
      nama: 'Izin Keramaian',
      dinas: 'Dinas Pelayanan Publik',
      jamOperasional: '08.00 - 14.00',
      keterangan:
          'Layanan permohonan izin untuk kegiatan yang melibatkan masyarakat.',
    ),
  ];

  static const List<Layanan> kesehatan = [
    Layanan(
      nama: 'Pendaftaran Puskesmas',
      dinas: 'Dinas Kesehatan',
      jamOperasional: '07.30 - 14.00',
      keterangan:
          'Layanan pendaftaran kunjungan masyarakat ke puskesmas.',
    ),
    Layanan(
      nama: 'Vaksinasi',
      dinas: 'Dinas Kesehatan',
      jamOperasional: '08.00 - 13.00',
      keterangan:
          'Layanan informasi dan pendaftaran program vaksinasi masyarakat.',
    ),
    Layanan(
      nama: 'Ambulans Kota',
      dinas: 'Dinas Kesehatan',
      jamOperasional: '24 Jam',
      keterangan:
          'Layanan bantuan transportasi medis darurat bagi warga.',
    ),
  ];

  static const List<Layanan> transportasi = [
    Layanan(
      nama: 'Kartu Transportasi',
      dinas: 'Dinas Perhubungan',
      jamOperasional: '08.00 - 16.00',
      keterangan:
          'Layanan pendaftaran dan informasi kartu transportasi kota.',
    ),
    Layanan(
      nama: 'Informasi Trayek',
      dinas: 'Dinas Perhubungan',
      jamOperasional: '24 Jam',
      keterangan:
          'Informasi mengenai rute dan trayek transportasi umum.',
    ),
    Layanan(
      nama: 'Pengaduan Transportasi',
      dinas: 'Dinas Perhubungan',
      jamOperasional: '08.00 - 16.00',
      keterangan:
          'Layanan pengaduan terkait transportasi umum di Kota Nusantara.',
    ),
  ];

  Future<void> bukaDetail(
    BuildContext context,
    Layanan layanan,
  ) async {
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detailLayanan,
      arguments: layanan,
    );

    if (!context.mounted) {
      return;
    }

    if (hasil != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(hasil.toString()),
          duration:
              const Duration(seconds: 3),
        ),
      );
    }
  }

  Widget kartuLayanan(
    BuildContext context,
    Layanan layanan,
  ) {
    final favorit =
        context.watch<FavoritModel>();

    final bool isFavorit =
        favorit.isFavorit(layanan.nama);

    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.all(16),
        leading: CircleAvatar(
          child: Icon(
            Icons.miscellaneous_services,
            color: Theme.of(context)
                .colorScheme
                .primary,
          ),
        ),
        title: Text(
          layanan.nama,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 6),
          child: Text(layanan.keterangan),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: isFavorit
                  ? 'Hapus dari favorit'
                  : 'Tambah ke favorit',
              onPressed: () {
                final model =
                    context.read<FavoritModel>();

                if (model.isFavorit(
                  layanan.nama,
                )) {
                  model.batalTandai(
                    layanan.nama,
                  );
                } else {
                  model.tandai(
                    layanan.nama,
                  );
                }
              },
              icon: Icon(
                isFavorit
                    ? Icons.star
                    : Icons.star_border,
                color: isFavorit
                    ? Colors.amber
                    : null,
              ),
            ),
            IconButton(
              onPressed: () {
                bukaDetail(
                  context,
                  layanan,
                );
              },
              icon: const Icon(
                Icons.chevron_right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget daftarLayanan(
    BuildContext context,
    List<Layanan> daftar,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftar.length,
      separatorBuilder:
          (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder:
          (context, index) {
        return kartuLayanan(
          context,
          daftar[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Theme.of(context)
                .colorScheme
                .surface,
            child: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.description_outlined,
                  ),
                  text: 'Perizinan',
                ),
                Tab(
                  icon: Icon(
                    Icons.local_hospital_outlined,
                  ),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(
                    Icons.directions_bus_outlined,
                  ),
                  text: 'Transportasi',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _TabLayanan(
                  daftar: perizinan,
                  kartuLayanan: kartuLayanan,
                ),
                _TabLayanan(
                  daftar: kesehatan,
                  kartuLayanan: kartuLayanan,
                ),
                _TabLayanan(
                  daftar: transportasi,
                  kartuLayanan: kartuLayanan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabLayanan extends StatelessWidget {
  final List<Layanan> daftar;

  final Widget Function(
    BuildContext,
    Layanan,
  ) kartuLayanan;

  const _TabLayanan({
    required this.daftar,
    required this.kartuLayanan,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftar.length,
      separatorBuilder:
          (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder:
          (context, index) {
        return kartuLayanan(
          context,
          daftar[index],
        );
      },
    );
  }
}