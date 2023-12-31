// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutixapp/models/models.dart';
import 'package:flutixapp/ui/pages/home/seat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class placesdate extends StatefulWidget {
  Movie movie;
  int? saldo;
  placesdate({super.key, required this.movie, required this.saldo});

  @override
  State<placesdate> createState() => _placesdateState();
}

class _placesdateState extends State<placesdate> {
  List<String> bioskop = [
    'Plaza Mulia CGV',
    'Samarinda Square XXI',
    'Big Mall XXI'
  ];

  List<String> jam = [
    '12:10',
    '14:50',
    '16:35',
    '18:45',
    '20:35',
    '21:25',
  ];

  int pilihTanggal = -1;
  Map<String, int> pilihJamMap = {};
  String pilihBioskop = "";
  String pilihJam = "";
  String pilihHari = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 0, 107, 152),
                size: 32,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color.fromARGB(255, 0, 107, 152),
                Color.fromARGB(255, 1, 3, 25),
                Color.fromARGB(255, 0, 107, 152),
              ],
            ),
          ),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Text(
                    "Choose Date",
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(7, (index) {
                      DateTime currentDate =
                          DateTime.now().add(Duration(days: index));
                      String namaHari = DateFormat('EEE').format(currentDate);
                      String tanggal = DateFormat('d').format(currentDate);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pilihTanggal = index;
                            pilihHari = "$namaHari , $tanggal";
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 90,
                          margin: EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 107, 152),
                            ),
                            color: pilihTanggal == index
                                ? Color.fromARGB(255, 0, 107, 152)
                                : Color.fromARGB(255, 0, 32, 69)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                namaHari,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                    color: pilihTanggal == index
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                tanggal,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                    color: pilihTanggal == index
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(
                        "Where to Watch ?",
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: List.generate(bioskop.length, (index) {
                        String namaBioskop = bioskop[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 5.0),
                              child: Text(
                                namaBioskop,
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(jam.length, (i) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        pilihJamMap[namaBioskop] = i;
                                        pilihBioskop = namaBioskop;
                                        pilihJam = jam[i];
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      margin: EdgeInsets.only(
                                        left: 20.0,
                                        top: 5.0,
                                        bottom: 15.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 0, 107, 152),
                                        ),
                                        color: pilihJamMap[namaBioskop] == i
                                            ? Color.fromARGB(255, 0, 107, 152)
                                            : Color.fromARGB(255, 0, 32, 69)
                                      ),
                                      child: Center(
                                        child: Text(
                                          jam[i],
                                          style: GoogleFonts.openSans(
                                            color: pilihJamMap[namaBioskop] == i
                                                ? Colors.white
                                                : Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 20, bottom: 40),
                          child: Text(
                            "Select Your Seat",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Seat(
                                      movie: widget.movie,
                                      namaBioskop: pilihBioskop,
                                      namaJam: pilihJam,
                                      namaHari: pilihHari,
                                      saldo: widget.saldo!,
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 105, right: 20, top: 50, bottom: 40),
                            child: Icon(
                              Icons.arrow_circle_right,
                              color: Color.fromARGB(255, 0, 107, 152),
                              size: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ));
  }
}
