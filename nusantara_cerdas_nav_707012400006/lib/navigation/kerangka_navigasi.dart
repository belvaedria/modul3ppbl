import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksAktif = 0;

  final List<Widget> halaman = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  void pindahTujuan(int indeks) {
    setState(() {
      indeksAktif = indeks;
    });
  }

  void bukaRouteDariDrawer(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  Widget ikonWarga({
    required bool terpilih,
    required int jumlah,
  }) {
    final icon = Icon(
      terpilih ? Icons.person : Icons.person_outline,
    );

    if (jumlah == 0) {
      return icon;
    }

    return Badge(
      label: Text(jumlah.toString()),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool layarLebar =
        MediaQuery.of(context).size.width >= 600;

    final int jumlahPengajuan = context.select<
        PengajuanModel,
        int>(
      (model) => model.totalPengajuan,
    );

    return PopScope(
      canPop: indeksAktif == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && indeksAktif != 0) {
          setState(() {
            indeksAktif = 0;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nusantara Cerdas'),
        ),
        drawer: NavigationDrawer(
          selectedIndex:
              indeksAktif < 3 ? indeksAktif : null,
          onDestinationSelected: (indeks) {
            if (indeks == 0) {
              Navigator.pop(context);
              pindahTujuan(0);
            } else if (indeks == 1) {
              Navigator.pop(context);
              pindahTujuan(1);
            } else if (indeks == 2) {
              Navigator.pop(context);
              pindahTujuan(2);
            } else if (indeks == 3) {
              bukaRouteDariDrawer(
                AppRoutes.pengaturanKota,
              );
            } else if (indeks == 4) {
              bukaRouteDariDrawer(
                AppRoutes.tentangAplikasi,
              );
            } else if (indeks == 5) {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Keluar'),
                    content: const Text(
                      'Apakah Anda yakin ingin keluar dari aplikasi?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Batal'),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Keluar'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(
                28,
                24,
                16,
                16,
              ),
              child: Text(
                'Nusantara Cerdas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            NavigationDrawerDestination(
              icon: Icon(
                Icons.miscellaneous_services_outlined,
              ),
              selectedIcon: Icon(
                Icons.miscellaneous_services,
              ),
              label: Text('Layanan'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: Text('Warga'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Divider(),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text('Pengaturan Kota'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.info_outline),
              selectedIcon: Icon(Icons.info),
              label: Text('Tentang Aplikasi'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.logout),
              selectedIcon: Icon(Icons.logout),
              label: Text('Keluar'),
            ),
          ],
        ),
        body: Row(
          children: [
            if (layarLebar)
              NavigationRail(
                selectedIndex: indeksAktif,
                onDestinationSelected: pindahTujuan,
                labelType:
                    NavigationRailLabelType.all,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Beranda'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(
                      Icons
                          .miscellaneous_services_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.miscellaneous_services,
                    ),
                    label: Text('Layanan'),
                  ),
                  NavigationRailDestination(
                    icon: ikonWarga(
                      terpilih: false,
                      jumlah: jumlahPengajuan,
                    ),
                    selectedIcon: ikonWarga(
                      terpilih: true,
                      jumlah: jumlahPengajuan,
                    ),
                    label: const Text('Warga'),
                  ),
                ],
              ),
            Expanded(
              child: IndexedStack(
                index: indeksAktif,
                children: halaman,
              ),
            ),
          ],
        ),
        bottomNavigationBar: layarLebar
            ? null
            : NavigationBar(
                selectedIndex: indeksAktif,
                onDestinationSelected:
                    pindahTujuan,
                destinations: [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  const NavigationDestination(
                    icon: Icon(
                      Icons
                          .miscellaneous_services_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.miscellaneous_services,
                    ),
                    label: 'Layanan',
                  ),
                  NavigationDestination(
                    icon: ikonWarga(
                      terpilih: false,
                      jumlah: jumlahPengajuan,
                    ),
                    selectedIcon: ikonWarga(
                      terpilih: true,
                      jumlah: jumlahPengajuan,
                    ),
                    label: 'Warga',
                  ),
                ],
              ),
      ),
    );
  }
}