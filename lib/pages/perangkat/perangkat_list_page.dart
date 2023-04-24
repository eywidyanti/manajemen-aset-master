import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/perangkat/add_perangkat.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/chipBar.dart';
import 'package:manajemen_aset/widget/perangkat_card.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class ListPerangkat extends StatefulWidget {
  final String docClusterId;
  const ListPerangkat({
    Key? key,
    required this.docClusterId,
  }) : super(key: key);

  @override
  State<ListPerangkat> createState() => _ListPerangkatState();
}

class _ListPerangkatState extends State<ListPerangkat> {
  String searchValue = '';

  late String _docClusterId;
  bool isSelected = true;
  var idSelected = 0;
  var icon = Icons;
  late List<ItemChipBar> _chipBarList;
  Widget currentTab() {
    return _chipBarList[idSelected].bodyWidget;
  }

  @override
  void initState() {
    super.initState();
    _docClusterId = widget.docClusterId;

    // list untuk choice chip
    _chipBarList = [
      // ItemChipBar(
      //   0,
      //   'Semua',
      //   BuilderPerangkat(
      //     stream: DatabaseService().listPerangkat(_docClusterId),
      //     docClusterId: _docClusterId,
      //   ),
      // ),
      ItemChipBar(
        const Icon(Icons.search),
        0,
        'PLTB',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatWT(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power),
        1,
        'PLTS',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatSP(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power_rounded),
        2,
        'PLTD',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatDS(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power),
        3,
        'Baterai',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatBT(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power),
        4,
        'Weather Station',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatWS(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power),
        5,
        'Rumah Energi',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatRE(_docClusterId),
          docClusterId: _docClusterId,
        ),
      ),
      ItemChipBar(
        const Icon(Icons.wind_power),
        6,
        'Warehouse',
        BuilderPerangkat(
          stream: DatabaseService().listPerangkatRE(_docClusterId),
          docClusterId: _docClusterId,
        ),
        // DropdownButton(items: items, onChanged: onChanged)
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text('Aset Pembangkit'),
        onSearch: (value) => setState(() => searchValue = value),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Color.fromARGB(225, 18, 149, 117),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // choice chip
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: listChip(),
              ),
            ),
            // content
            Center(
              child: currentTab(),
            ),
          ],
        ),
      ),
      floatingActionButton:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: DatabaseService().userRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasData) {
            String role = snapshot.data!.data()!['role'];
            // cek user untuk menampilkan tombol tambah data aset
            if (role == 'Operator Vendor') {
              return FloatingActionButton(
                backgroundColor: const Color.fromARGB(225, 18, 149, 117),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPerangkat(
                        docId: _docClusterId,
                      ),
                    ),
                  );
                },
              );
            } else {
              null;
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

//scroll
  listChip() {
    return Row(
      children: [
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.wind_power),
          label: const Text(
            'PLTB',
            style: TextStyle(fontSize: 14),
          ),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          onSelected: (_) => setState(() => idSelected = 0),
          backgroundColor: const Color.fromARGB(225, 18, 149, 117),
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.solar_power),
          label: const Text(
            'PLTS',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.energy_savings_leaf),
          label: const Text(
            'PLTD',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.battery_6_bar),
          label: const Text(
            'Baterai',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.cloud),
          label: const Text(
            'Weather Station',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.lightbulb),
          label: const Text(
            'Rumah Energi',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
        InputChip(
          avatar: const Icon(Icons.warehouse),
          label: const Text(
            'Warehouse',
            style: TextStyle(fontSize: 14),
          ),
          onSelected: (bool value) {},
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

class BuilderPerangkat extends StatelessWidget {
  final String docClusterId;
  final stream;
  const BuilderPerangkat({
    Key? key,
    required this.stream,
    required this.docClusterId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return Column(
              children: [
                Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final documentSnapshot = snapshot.data!.docs[index];
                        final String docId = snapshot.data!.docs[index].id;
                        String id = documentSnapshot['id'];
                        String kode = documentSnapshot['kode'];
                        String jenis = documentSnapshot['jenis'];
                        String status = documentSnapshot['status'];
                        String img = '';
                        if (jenis == 'PLTB') {
                          img = 'img/pltb.png';
                        } else if (jenis == 'PLTS') {
                          img = 'img/plts.png';
                        } else if (jenis == 'Diesel') {
                          img = 'img/pltd.png';
                        } else if (jenis == 'Baterai') {
                          img = 'img/battery.png';
                        } else if (jenis == 'Weather Station') {
                          img = 'img/ws.png';
                        } else if (jenis == 'Rumah Energi') {
                          img = 'img/rumah-energi.png';
                        } else if (jenis == 'Warehouse') {
                          img = 'img/rumah-energi.png';
                        }
                        return PerangkatCard(
                          docClusterId: docClusterId,
                          docPerangkatId: docId,
                          id: id,
                          kode: kode,
                          status: status,
                          img: img,
                          jenis: jenis,
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
