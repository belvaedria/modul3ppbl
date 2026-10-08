import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Warga Nusantara',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'warga@nusantara.go.id',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Layanan Favorit',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Consumer<FavoritModel>(
            builder: (
              context,
              favorit,
              child,
            ) {
              if (favorit
                  .layananFavorit.isEmpty) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Belum ada layanan favorit.',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Card(
                child: Column(
                  children: favorit
                      .layananFavorit
                      .map(
                    (nama) {
                      return ListTile(
                        leading:
                            const Icon(
                          Icons.star,
                          color:
                              Colors.amber,
                        ),
                        title: Text(nama),
                        trailing:
                            IconButton(
                          onPressed: () {
                            context
                                .read<
                                    FavoritModel>()
                                .batalTandai(
                                  nama,
                                );
                          },
                          icon:
                              const Icon(
                            Icons
                                .star_border,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Consumer<PengajuanModel>(
            builder: (
              context,
              pengajuan,
              child,
            ) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  title: const Text(
                    'Pengajuan Layanan',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${pengajuan.totalPengajuan} layanan sedang diajukan',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading:
                  const Icon(Icons.history),
              title: const Text(
                'Riwayat Laporan',
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Lihat laporan warga yang pernah dibuat',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.riwayatLaporan,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}