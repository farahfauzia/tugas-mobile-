import 'package:flutter/material.dart';

const _ink = Color(0xFF1D2A25);
const _paper = Color(0xFFF4F6F0);
const _leaf = Color(0xFFC7E879);
const _coral = Color(0xFFE47A61);
const _blue = Color(0xFF4F8190);
const _line = Color(0xFFDDE3D8);

void main() {
  runApp(const StudentJournalApp());
}

class StudentJournalApp extends StatelessWidget {
  const StudentJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruang Kajian Farah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _ink,
          primary: _ink,
          secondary: _coral,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: _paper,
        appBarTheme: const AppBarTheme(
          backgroundColor: _paper,
          foregroundColor: _ink,
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: _ink,
            fontSize: 42,
            height: 1.08,
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            color: _ink,
            fontSize: 30,
            height: 1.15,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            color: _ink,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Color(0xFF435149),
            fontSize: 16,
            height: 1.7,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF526057),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/page-2': (context) => const Page2(),
        '/page-3': (context) => const Page3(),
        '/page-4': (context) => const Page4(),
      },
    );
  }
}

String _routeFor(int page) => page == 1 ? '/' : '/page-$page';

void _openPage(BuildContext context, int page) {
  Navigator.pushNamed(context, _routeFor(page));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteFrame(currentPage: 1, child: _IdentityContent());
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteFrame(currentPage: 2, child: _OpeningDiscussionContent());
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteFrame(currentPage: 3, child: _FurtherDiscussionContent());
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteFrame(currentPage: 4, child: _ClosingContent());
  }
}

class SiteFrame extends StatelessWidget {
  const SiteFrame({required this.currentPage, required this.child, super.key});

  final int currentPage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        titleSpacing: 24,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                'R',
                style: TextStyle(
                  color: _leaf,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RUANG KAJIAN',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Catatan prestasi & penelitian',
                  style: TextStyle(fontSize: 11, color: Color(0xFF66736A)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final content = SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(isWide ? 48 : 20, 32, isWide ? 48 : 20, 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1040),
                child: child,
              ),
            ),
          );

          if (!isWide) return content;

          return Row(
            children: [
              SizedBox(width: 244, child: _SideNavigation(currentPage: currentPage)),
              const VerticalDivider(width: 1, thickness: 1, color: _line),
              Expanded(child: content),
            ],
          );
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) return const SizedBox.shrink();
          return NavigationBar(
            selectedIndex: currentPage - 1,
            onDestinationSelected: (index) => _openPage(context, index + 1),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.badge_outlined),
                selectedIcon: Icon(Icons.badge),
                label: 'Identitas',
              ),
              NavigationDestination(
                icon: Icon(Icons.article_outlined),
                selectedIcon: Icon(Icons.article),
                label: 'Awal',
              ),
              NavigationDestination(
                icon: Icon(Icons.science_outlined),
                selectedIcon: Icon(Icons.science),
                label: 'Lanjutan',
              ),
              NavigationDestination(
                icon: Icon(Icons.flag_outlined),
                selectedIcon: Icon(Icons.flag),
                label: 'Penutup',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SideNavigation extends StatelessWidget {
  const _SideNavigation({required this.currentPage});

  final int currentPage;

  static const _labels = [
    'Identitas',
    'Pembahasan awal',
    'Pembahasan lanjutan',
    'Penutup',
  ];
  static const _icons = [
    Icons.badge_outlined,
    Icons.article_outlined,
    Icons.science_outlined,
    Icons.flag_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 14, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 0, 14),
            child: Text(
              'DAFTAR HALAMAN',
              style: TextStyle(
                color: Color(0xFF78847B),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          for (var index = 0; index < _labels.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListTile(
                selected: currentPage == index + 1,
                selectedTileColor: _leaf.withValues(alpha: 0.38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(_icons[index], size: 20),
                title: Text(_labels[index]),
                onTap: () => _openPage(context, index + 1),
              ),
            ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _line),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.menu_book_outlined, color: _blue),
                SizedBox(height: 10),
                Text(
                  'Belajar, meneliti, bertumbuh.',
                  style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
                ),
                SizedBox(height: 4),
                Text(
                  'Sebuah ringkasan tentang semangat berprestasi.',
                  style: TextStyle(color: Color(0xFF66736A), height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentityContent extends StatelessWidget {
  const _IdentityContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Eyebrow(label: 'TUGAS WEBSITE  /  4 HALAMAN'),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 680;
            const introduction = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, saya Farah.',
                  style: TextStyle(color: _ink, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                Text(
                  'Ruang untuk\nide yang bertumbuh.',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 48,
                    height: 1.04,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Mengenal kisah Shakira dan Kadit: dari publikasi ilmiah hingga panggung Olimpiade Matematika.',
                  style: TextStyle(color: Color(0xFF526057), fontSize: 17, height: 1.65),
                ),
              ],
            );

            return Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExpandedIfWide(isWide: isWide, child: introduction),
                SizedBox(width: isWide ? 48 : 0, height: isWide ? 0 : 30),
                ExpandedIfWide(isWide: isWide, child: const _ResearchArtwork()),
              ],
            );
          },
        ),
        const SizedBox(height: 34),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 620;
            return Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              children: [
                ExpandedIfWide(isWide: isWide, child: const _IdentityCard()),
                SizedBox(width: isWide ? 18 : 0, height: isWide ? 0 : 14),
                ExpandedIfWide(isWide: isWide, child: const _AboutAssignmentCard()),
              ],
            );
          },
        ),
        const SizedBox(height: 34),
        const _SectionHeading(eyebrow: 'JELAJAHI', title: 'Empat bagian, satu cerita.'),
        const SizedBox(height: 16),
        const PageLinks(currentPage: 1),
      ],
    );
  }
}

class ExpandedIfWide extends StatelessWidget {
  const ExpandedIfWide({required this.isWide, required this.child, super.key});

  final bool isWide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isWide ? Expanded(child: child) : child;
  }
}

class _ResearchArtwork extends StatelessWidget {
  const _ResearchArtwork();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RISET × MATEMATIKA',
                style: TextStyle(color: _leaf, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1),
              ),
              Icon(Icons.north_east, color: _leaf, size: 18),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '16',
                style: TextStyle(color: Colors.white, fontSize: 76, height: 0.95, fontWeight: FontWeight.w800),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 8),
                  child: Text(
                    'jurnal ilmiah\ndalam satu kisah',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 13, height: 1.45),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) => DecoratedBox(
              decoration: BoxDecoration(
                color: index % 5 == 0 ? _coral : _leaf.withValues(alpha: index % 2 == 0 ? 0.92 : 0.38),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'SATU LANGKAH KECIL, BANYAK KEMUNGKINAN',
            style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.65),
          ),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Eyebrow(label: 'IDENTITAS MAHASISWA'),
          const SizedBox(height: 16),
          const Text('Farah Naylul Fauzia', style: TextStyle(color: _ink, fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 7),
          const Text('NIM  253140701111039', style: TextStyle(color: Color(0xFF66736A), fontSize: 14)),
          const SizedBox(height: 18),
          Container(height: 1, color: _line),
          const SizedBox(height: 14),
          const Row(
            children: [
              Icon(Icons.language, color: _blue, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Proyek navigasi Flutter Web',
                  style: TextStyle(color: _ink, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutAssignmentCard extends StatelessWidget {
  const _AboutAssignmentCard();

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      color: const Color(0xFFE8EFE6),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(label: 'TENTANG KISAH INI'),
          SizedBox(height: 16),
          Text(
            'Dua bidang, semangat yang sama.',
            style: TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w700, height: 1.2),
          ),
          SizedBox(height: 9),
          Text(
            'Ikuti pembahasan tentang publikasi ilmiah, proses belajar, dan prestasi matematika Shakira dan Kadit.',
            style: TextStyle(color: Color(0xFF526057), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _OpeningDiscussionContent extends StatelessWidget {
  const _OpeningDiscussionContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ArticleHeading(
          pageLabel: 'PEMBAHASAN AWAL',
          title: 'Riset bertemu\nlogika angka.',
          subtitle: 'Mengenal Shakira dan Kadit lewat kabar tentang publikasi ilmiah dan Olimpiade Matematika.',
          accent: _coral,
        ),
        const SizedBox(height: 26),
        const _ArticleSection(
          number: '01',
          title: 'Dua nama dalam satu kisah',
          child: 'Shakira dan Kadit adalah dua sosok yang diangkat dalam topik ini sebagai pelajar berprestasi. Kisah mereka menarik karena mempertemukan dua kegiatan yang saling menguatkan: menyusun gagasan menjadi penelitian dan mengasah penalaran melalui matematika.',
        ),
        const SizedBox(height: 14),
        const _ArticleSection(
          number: '02',
          title: 'Apa arti 16 jurnal ilmiah?',
          child: 'Angka 16 merujuk pada jumlah publikasi yang disebut dalam topik pembahasan. Setiap jurnal ilmiah berangkat dari pertanyaan, penelusuran sumber, metode, dan penyajian temuan secara runtut. Publikasi sebanyak itu menyoroti konsistensi dalam mengembangkan dan membagikan gagasan.',
        ),
        const SizedBox(height: 14),
        const _ArticleSection(
          number: '03',
          title: 'Dari penelitian ke olimpiade',
          child: 'Topik tersebut juga menyebut kemenangan di Olimpiade Matematika. Kompetisi ini menuntut ketelitian membaca soal, memilih strategi, dan memeriksa jawaban. Jadi, kisahnya bukan hanya tentang jumlah publikasi, tetapi juga tentang ketekunan menghadapi tantangan akademik yang berbeda.',
        ),
        const SizedBox(height: 18),
        const _ContextNote(
          text: 'Informasi yang tersedia di sini mengikuti garis besar judul. Nama kompetisi, waktu, judul publikasi, dan rincian biografi tidak ditambahkan karena belum dicantumkan.',
        ),
        const SizedBox(height: 30),
        const PageLinks(currentPage: 2),
      ],
    );
  }
}

class _FurtherDiscussionContent extends StatelessWidget {
  const _FurtherDiscussionContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ArticleHeading(
          pageLabel: 'PEMBAHASAN LANJUTAN',
          title: 'Prestasi lahir\ndari proses.',
          subtitle: 'Melihat kebiasaan dan keterampilan yang menopang perjalanan akademik, bukan sekadar hasil akhirnya.',
          accent: _blue,
        ),
        const SizedBox(height: 26),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            const sections = [
              _InsightCard(
                icon: Icons.search,
                title: 'Rasa ingin tahu',
                text: 'Penelitian dimulai dengan pertanyaan yang jelas. Membaca, membandingkan sumber, lalu menyusun cara untuk mencari jawaban adalah latihan berpikir yang bisa terus diasah.',
                color: Color(0xFFE5EEE9),
              ),
              _InsightCard(
                icon: Icons.edit_note,
                title: 'Menulis dengan teliti',
                text: 'Publikasi ilmiah mengajak penulis menjelaskan proses dan temuan secara terstruktur. Sebanyak 16 jurnal dalam kisah ini menjadi pengingat akan besarnya kerja konsisten di balik sebuah tulisan.',
                color: Color(0xFFF4E8E2),
              ),
              _InsightCard(
                icon: Icons.functions,
                title: 'Berpikir strategis',
                text: 'Olimpiade Matematika melatih peserta untuk memahami pola, mencoba pendekatan, dan mengevaluasi langkah. Ketelitian sering sama pentingnya dengan menemukan jawaban.',
                color: Color(0xFFE8EED8),
              ),
              _InsightCard(
                icon: Icons.repeat,
                title: 'Belajar berkelanjutan',
                text: 'Riset dan kompetisi sama-sama membutuhkan latihan berulang. Kemajuan biasanya terbentuk dari target kecil, umpan balik, dan kemauan memperbaiki strategi.',
                color: Color(0xFFE5ECF0),
              ),
            ];

            if (!isWide) {
              return Column(
                children: [
                  for (var index = 0; index < sections.length; index++) ...[
                    sections[index],
                    if (index < sections.length - 1) const SizedBox(height: 14),
                  ],
                ],
              );
            }

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.65,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: sections,
            );
          },
        ),
        const SizedBox(height: 22),
        _PaperCard(
          color: _ink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Eyebrow(label: 'SATU PELAJARAN PENTING', color: _leaf),
              const SizedBox(height: 12),
              Text(
                'Angka 16 dan gelar juara adalah capaian yang terlihat. Di baliknya, proses belajar, ketekunan meneliti, dan keberanian mencoba adalah hal yang bisa diteladani.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const PageLinks(currentPage: 3),
      ],
    );
  }
}

class _ClosingContent extends StatelessWidget {
  const _ClosingContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ArticleHeading(
          pageLabel: 'PENUTUP',
          title: 'Terus tumbuh,\nterus mencoba.',
          subtitle: 'Kesimpulan dari kisah Shakira dan Kadit.',
          accent: _leaf,
        ),
        const SizedBox(height: 26),
        _PaperCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Eyebrow(label: 'KESIMPULAN'),
              const SizedBox(height: 16),
              Text(
                'Kisah Shakira dan Kadit menghubungkan publikasi 16 jurnal ilmiah dengan prestasi di Olimpiade Matematika. Keduanya menunjukkan bahwa ruang untuk berprestasi tidak hanya satu: gagasan dapat diuji melalui penelitian, sementara penalaran dapat diasah lewat tantangan matematika.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Pesan yang dapat dibawa pulang sederhana: prestasi dapat dicapai melalui ketekunan dalam belajar, penelitian, dan pengembangan diri. Kemajuan besar pun berawal dari rasa ingin tahu dan langkah kecil yang dilakukan dengan konsisten.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: _leaf, borderRadius: BorderRadius.circular(14)),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: _ink),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Mulai dari pertanyaan. Lanjutkan dengan usaha. Biarkan proses membawamu lebih jauh.',
                  style: TextStyle(color: _ink, fontSize: 18, height: 1.45, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const PageLinks(currentPage: 4),
      ],
    );
  }
}

class _ArticleHeading extends StatelessWidget {
  const _ArticleHeading({
    required this.pageLabel,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String pageLabel;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 108,
            decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Eyebrow(label: pageLabel),
                const SizedBox(height: 12),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 10),
                Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleSection extends StatelessWidget {
  const _ArticleSection({required this.number, required this.title, required this.child});

  final String number;
  final String title;
  final String child;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(color: _coral, fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(child, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.icon, required this.title, required this.text, required this.color});

  final IconData icon;
  final String title;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _ink, size: 22),
          const SizedBox(height: 14),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 7),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _ContextNote extends StatelessWidget {
  const _ContextNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E8),
        borderRadius: BorderRadius.circular(10),
        border: const Border(left: BorderSide(color: _coral, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: _coral, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class PageLinks extends StatelessWidget {
  const PageLinks({required this.currentPage, super.key});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final pages = List<int>.generate(4, (index) => index + 1)
        .where((page) => page != currentPage)
        .toList();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final page in pages)
          OutlinedButton.icon(
            onPressed: () => _openPage(context, page),
            icon: Icon(page < currentPage ? Icons.arrow_back : Icons.arrow_forward, size: 17),
            label: Text(page == 1 ? 'Kembali ke Halaman 1' : 'Ke Halaman $page'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _ink,
              side: const BorderSide(color: _line),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.eyebrow, required this.title});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Eyebrow(label: eyebrow),
        const SizedBox(height: 7),
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
      ],
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.label, this.color = _blue});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w800, letterSpacing: 0.8),
    );
  }
}

class _PaperCard extends StatelessWidget {
  const _PaperCard({required this.child, this.color = Colors.white});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: color,
        border: color == Colors.white ? Border.all(color: _line) : null,
        borderRadius: BorderRadius.circular(13),
      ),
      child: child,
    );
  }
}