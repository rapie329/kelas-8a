import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/modal_kas.dart';

class KasView extends StatefulWidget {
  final KelasRepository repo;

  const KasView({super.key, required this.repo});

  @override
  State<KasView> createState() => _KasViewState();
}

class _KasViewState extends State<KasView> {
  String _filter = 'semua';

  String _formatRupiah(int val) {
    final f = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return f.format(val);
  }

  void _bukaModalTambah(String tipe) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalTambahKas(
        initialTipe: tipe,
        onSave: (transaksi) {
          widget.repo.addKas(transaksi);
        },
      ),
    );
  }

  void _konfirmasiHapus(String id) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Hapus Transaksi'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan transaksi ini dari kas kelas?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Hapus'),
            onPressed: () {
              widget.repo.deleteKas(id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allKas = widget.repo.kasList;
    final list = _filter == 'masuk'
        ? allKas.where((k) => k.tipe == 'masuk').toList()
        : _filter == 'keluar'
            ? allKas.where((k) => k.tipe == 'keluar').toList()
            : allKas;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Buku Kas 8A'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _bukaModalTambah('masuk'),
          child: const Icon(CupertinoIcons.plus_circle_fill, size: 24),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            const Text(
              'TRANSPARANSI KEUANGAN',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel, letterSpacing: 0.5),
            ),
            const SizedBox(height: 2),
            const Text(
              'Buku Kas Kelas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.8),
            ),
            const SizedBox(height: 14),

            // Financial Balance Master Card
            IosCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo Kas Saat Ini', style: TextStyle(fontSize: 13, color: CupertinoColors.secondaryLabel, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                    _formatRupiah(widget.repo.saldoKas),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: CupertinoColors.activeBlue, letterSpacing: -0.8),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(top: 14),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(CupertinoIcons.arrow_down_left, size: 13, color: CupertinoColors.systemGreen),
                                  SizedBox(width: 4),
                                  Text('Total Pemasukan', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGreen, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatRupiah(widget.repo.totalPemasukan),
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CupertinoColors.systemGreen),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(CupertinoIcons.arrow_up_right, size: 13, color: CupertinoColors.systemRed),
                                  SizedBox(width: 4),
                                  Text('Total Pengeluaran', style: TextStyle(fontSize: 11, color: CupertinoColors.systemRed, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatRupiah(widget.repo.totalPengeluaran),
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CupertinoColors.systemRed),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    color: CupertinoColors.activeBlue.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    onPressed: () => _bukaModalTambah('masuk'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.add, size: 16, color: CupertinoColors.activeBlue),
                        SizedBox(width: 6),
                        Text('+ Kas Masuk', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: CupertinoColors.activeBlue)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    color: CupertinoColors.systemRed.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    onPressed: () => _bukaModalTambah('keluar'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.minus, size: 16, color: CupertinoColors.systemRed),
                        SizedBox(width: 6),
                        Text('- Pengeluaran', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: CupertinoColors.systemRed)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Segmented Control Filter
            Center(
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _filter,
                  children: const {
                    'semua': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Semua')),
                    'masuk': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Pemasukan')),
                    'keluar': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Pengeluaran')),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _filter = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'RIWAYAT TRANSAKSI',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 8),

            IosCard(
              padding: EdgeInsets.zero,
              child: list.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: Text(
                          'Belum ada transaksi pada filter ini.',
                          style: TextStyle(color: CupertinoColors.secondaryLabel),
                        ),
                      ),
                    )
                  : Column(
                      children: list.map((item) {
                        final isMasuk = item.tipe == 'masuk';
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: (isMasuk ? CupertinoColors.systemGreen : CupertinoColors.systemRed).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isMasuk ? CupertinoIcons.arrow_down_left : CupertinoIcons.arrow_up_right,
                                  size: 16,
                                  color: isMasuk ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.keterangan, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${DateFormat('dd MMM yyyy').format(item.tanggal)} • ${item.kategori}',
                                      style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${isMasuk ? '+' : '-'} ${_formatRupiah(item.nominal)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: isMasuk ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
                                ),
                              ),
                              const SizedBox(width: 4),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _konfirmasiHapus(item.id),
                                child: const Icon(CupertinoIcons.trash, size: 15, color: CupertinoColors.systemGrey3),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
