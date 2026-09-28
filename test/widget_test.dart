import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('halaman dapat dijelajahi dan tombol kembali berfungsi', (tester) async {
    await tester.pumpWidget(const StudentJournalApp());

    expect(find.text('Farah Naylul Fauzia'), findsOneWidget);

    await tester.tap(find.text('Awal'));
    await tester.pumpAndSettle();
    expect(find.text('Riset bertemu\nlogika angka.'), findsOneWidget);

    await tester.tap(find.text('Lanjutan'));
    await tester.pumpAndSettle();
    expect(find.text('Prestasi lahir\ndari proses.'), findsOneWidget);

    await tester.tap(find.text('Penutup'));
    await tester.pumpAndSettle();
    expect(find.text('Terus tumbuh,\nterus mencoba.'), findsOneWidget);

    final homeLink = find.text('Kembali ke Halaman 1');
    await tester.ensureVisible(homeLink);
    await tester.tap(homeLink);
    await tester.pumpAndSettle();
    expect(find.text('Farah Naylul Fauzia'), findsOneWidget);
  });
}