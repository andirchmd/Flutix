import 'package:flutixapp/models/models.dart';
import 'package:flutixapp/ui/pages/home/checkout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Seat extends StatefulWidget {
  Movie movie;

  Seat({Key? key, required this.movie, required this.namaJam, required this.namaHari, required this.namaBioskop, required this.saldo}) : super(key: key);

  String namaBioskop;
  String namaJam;
  String namaHari;
  int saldo;

  @override
  _SeatState createState() => _SeatState();
}

Color kSeatBookedColor = const Color.fromARGB(255, 0, 32, 69);
Color kSeatSelectedColor = const Color.fromARGB(255, 0, 107, 152);

class _SeatState extends State<Seat> {
  List<List<bool>> seatStatus =
      List.generate(8, (index) => List.filled(6, false));
  List<String> selectedSeats = [];

  Widget buildSeatContainer(String seatText, int row, int col) {
    return InkWell(
      onTap: () {
        setState(() {
          seatStatus[row][col] = !seatStatus[row][col];
        });
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: seatStatus[row][col] ? kSeatSelectedColor : Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 0, 107, 152), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(seatText),
        ),
      ),
    );
  }

  List<Widget> buildSeatRow(String rowName, int row) {
    List<Widget> rowWidgets = List.generate(6, (col) {
      final seatText = "$rowName${6 - col}";
      return buildSeatContainer(seatText, row, col);
    });
    return rowWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [      
              Color.fromARGB(255, 0, 107, 152),
              Color.fromARGB(255, 1, 3, 25),
              Color.fromARGB(255, 0, 107, 152),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: 320,
                  height: 10,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 123, 122, 122),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Layar Bioskop",
                      style: GoogleFonts.raleway(fontSize: 14, 
                      color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                8,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildSeatRow(
                    String.fromCharCode('H'.codeUnitAt(0) - index),
                    index,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(left: 50, right: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: kSeatBookedColor,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Booked",
                        style: GoogleFonts.raleway(fontSize: 12, 
                        color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color.fromARGB(255, 0, 107, 152), width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Available",
                        style: GoogleFonts.raleway(fontSize: 12,
                        color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                        color: kSeatSelectedColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        "Selected",
                        style: GoogleFonts.raleway(fontSize: 12, 
                        color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, bottom: 40),
                  child: Text(
                    "Confirm Your Book",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectedSeats.clear();
                        for (int i = 0; i < seatStatus.length; i++) {
                          for (int j = 0; j < seatStatus[i].length; j++) {
                            if (seatStatus[i][j]) {
                              selectedSeats.add(
                                  String.fromCharCode('H'.codeUnitAt(0) - i) +
                                      (6 - j).toString());
                            }
                          }
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => checkout(
                              namaBioskop: widget.namaBioskop,
                              namaJam: widget.namaJam,
                              namaHari: widget.namaHari,
                              selectedSeats: selectedSeats,
                              saldo: widget.saldo,
                              movies: widget.movie,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 50, bottom: 40),
                        child: Icon(
                          Icons.arrow_circle_right,
                          color: kSeatSelectedColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
