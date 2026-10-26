import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portofolio_rahmad/main.dart';

void main() {
  testWidgets('Portfolio menampilkan bagian utama', (WidgetTester tester) async {
    // Gunakan ukuran layar desktop untuk pengujian.
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());

    // Periksa judul utama halaman.
    expect(find.text("HELLO, I'M"), findsOneWidget);

    // Periksa judul bagian Skills dan Proyek.
    expect(find.text('Skills & Teknologi'), findsOneWidget);
    expect(find.text('Proyek Pilihan'), findsOneWidget);
  });
}