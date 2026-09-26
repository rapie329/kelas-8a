import 'package:flutter/cupertino.dart';
import 'data/kelas_repository.dart';
import 'views/beranda_view.dart';
import 'views/jadwal_view.dart';
import 'views/tugas_view.dart';
import 'views/kas_view.dart';
import 'views/siswa_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Kelas8AApp());
}

class Kelas8AApp extends StatefulWidget {
  const Kelas8AApp({super.key});

  @override
  State<Kelas8AApp> createState() => _Kelas8AAppState();
}

class _Kelas8AAppState extends State<Kelas8AApp> {
  final KelasRepository _repo = KelasRepository();

  @override
  void initState() {
    super.initState();
    _repo.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _repo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _repo.isDarkMode;

    return CupertinoApp(
      title: 'Kelas 8A',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: isDark
            ? CupertinoColors.black
            : const Color(0xFFF2F2F7),
        barBackgroundColor: isDark
            ? const Color(0xE61C1C1E)
            : const Color(0xF2F9F9F9),
        textTheme: const CupertinoTextThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
      ),
      home: MainTabBarController(repo: _repo),
    );
  }
}

class MainTabBarController extends StatefulWidget {
  final KelasRepository repo;

  const MainTabBarController({super.key, required this.repo});

  @override
  State<MainTabBarController> createState() => _MainTabBarControllerState();
}

class _MainTabBarControllerState extends State<MainTabBarController> {
  final CupertinoTabController _tabController = CupertinoTabController();

  void _navigateToTab(int index) {
    _tabController.index = index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.checkmark_square_fill),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar_circle_fill),
            label: 'Kas',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: 'Kelas',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return BerandaView(repo: widget.repo, onNavigateTab: _navigateToTab);
          case 1:
            return JadwalView(repo: widget.repo);
          case 2:
            return TugasView(repo: widget.repo);
          case 3:
            return KasView(repo: widget.repo);
          case 4:
            return SiswaView(repo: widget.repo);
          default:
            return BerandaView(repo: widget.repo, onNavigateTab: _navigateToTab);
        }
      },
    );
  }
}
