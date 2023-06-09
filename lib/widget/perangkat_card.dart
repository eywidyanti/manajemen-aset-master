import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/perangkat/list.dart';
import 'package:manajemen_aset/widget/new_perangkat.dart';

class PerangkatCard extends StatelessWidget {
  const PerangkatCard({
    Key? key,
    required this.docClusterId,
    required this.docPerangkatId,
    required this.id,
    required this.kode,
    required this.status,
    required this.img,
    required this.jenis,
  }) : super(key: key);

  final String docClusterId;
  final String docPerangkatId;
  final String id;
  final String kode;
  final String status;
  final String img;
  final String jenis;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListP(
              docClusterId: docClusterId,
              docPerangkatId: docPerangkatId,
              perangkatId: id,
              jenisPerangkat: jenis,
              kodePerangkat: kode,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.06),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Positioned(
                left: 40.0,
                top: 100.0,
                child: SizedBox(
                  width: 50, // atur lebar gambar
                  height: 50, // atur tinggi gambar
                  child: Image.asset(img),
                ),
              ),
              // Align(
              //   image: AssetImage(img),
              //   width: 60,
              //   alignment: Alignment.topLeft,
              // ),
              const SizedBox(
                width: 16,
                height: 10,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // kode aset
                        Text(
                          kode,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(225, 18, 149, 117),
                          ),
                        ),

                        const SizedBox(width: 8),
                        // icon status
                        Icon(
                          status == "kosong" ? Icons.add : Icons.task_alt,
                          color:
                              status == "kosong" ? Colors.grey : Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: const <Widget>[
                        NewText(text1: 'Nama Asset = PLTBT'),
                        NewText(text1: 'Kode Asset = PLTB.TUBAN.1'),
                        NewText(text1: 'Produksi = 62 Kwh'),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          'Status = Peringatan',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(
                          // <-- Icon
                          Icons.warning_amber_outlined,
                          size: 24.0,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          'Alarm = Aman',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(
                          // <-- Icon
                          Icons.safety_check,
                          size: 24.0,
                          color: Colors.green,
                        ),
                      ],
                    )
                    // const SizedBox(height: 8),
                    // SizedBox(
                    //   // width: 100,
                    //   child: Text(
                    //     status,
                    //     maxLines: 1,
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // PopupMenuButton<int>(
              //   iconSize: 20,
              //   itemBuilder: (context) => [
              //     // PopupMenuItem 1
              //     PopupMenuItem(
              //       value: 1,
              //       child: Row(
              //         children: const [
              //           Icon(Icons.edit),
              //           SizedBox(width: 10),
              //           Text("Edit Perangkat")
              //         ],
              //       ),
              //     ),
              //     // PopupMenuItem 2
              //     PopupMenuItem(
              //       value: 2,
              //       child: Row(
              //         children: const [
              //           Icon(Icons.delete),
              //           SizedBox(width: 10),
              //           Text("Hapus Perangkat")
              //         ],
              //       ),
              //     ),
              //   ],
              //   onSelected: (value) {
              //     if (value == 1) {
              //       // edit perangkat
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => EditPerangkat(
              //             docClusterId: docClusterId,
              //             docPerangkatId: docPerangkatId,
              //             currentId: id,
              //             currentJenis: jenis,
              //             currentKode: kode,
              //             currentStatus: status,
              //           ),
              //         ),
              //       );
              //     } else if (value == 2) {
              //       // hapus perangkat
              //       showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: const Text("Hapus"),
              //           content: Text(
              //             "Apakah anda yakin akan menghapus perangkat $kode? ",
              //           ),
              //           actions: <Widget>[
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text(
              //                 "Batal",
              //                 style: TextStyle(
              //                   color: Color.fromARGB(225, 125, 122, 116),
              //                 ),
              //               ),
              //             ),
              //             TextButton(
              //               onPressed: () async {
              //                 await DatabaseService().deletePerangkat(
              //                   docClusterId: docClusterId,
              //                   docPerangkatId: docPerangkatId,
              //                 );
              //                 Navigator.pop(context);
              //               },
              //               child: const Text("Hapus"),
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
