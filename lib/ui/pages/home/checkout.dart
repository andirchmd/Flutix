import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutixapp/models/models.dart';
import 'package:flutixapp/providers/walletBalance.dart';
import 'package:flutixapp/ui/pages/home/success_checkout.dart';
import 'package:flutixapp/ui/pages/home/wallettopup.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class checkout extends StatefulWidget {
  List<String> selectedSeats;
  Movie movies;
  String namaBioskop;
  String namaJam;
  String namaHari;
  int saldo;

  checkout({
    Key? key,
    required this.movies,
    required this.namaJam,
    required this.namaHari,
    required this.selectedSeats,
    required this.saldo,
    required this.namaBioskop,
  }) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  final bool _isAda = true;

  String generateOrderId() {
    Random random = Random();
    List<int> orderIds = [];

    while (orderIds.length < 5) {
      int orderId = random.nextInt(1000);
      if (!orderIds.contains(orderId)) {
        orderIds.add(orderId);
      }
    }

    String orderIdString = orderIds.join('');
    return orderIdString;
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletBalance>(context);
    double rating = widget.movies.rate / 2;
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) > 0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 107, 152),
            Color.fromARGB(255, 1, 3, 25),
            Color.fromARGB(255, 0, 107, 152),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFE1A20B),
                size: 32,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, bottom: 10.0, top: 10, right: 20),
                  child: Text(
                    "Check Details Below Before Checkout",
                    style: GoogleFonts.raleway(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 90,
                      height: 110,
                      margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Image.network(
                        widget.movies.poster,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.movies.judul,
                              style: GoogleFonts.raleway(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 10, bottom: 10),
                          child: Text(
                            widget.movies.genre.join(", "),
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: List.generate(
                                  fullStars,
                                  (starIndex) {
                                    return const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 238, 255, 0),
                                      size: 16,
                                    );
                                  },
                                ),
                              ),
                              if (hasHalfStar)
                                const Icon(
                                  Icons.star_half,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 16,
                                ),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.movies.rate.toStringAsFixed(1)}/10",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                  thickness: 2,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID Order",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            generateOrderId(),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cinema",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.namaBioskop,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date & Time",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${widget.namaHari}, ${widget.namaJam}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.selectedSeats.length} Tickets",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.selectedSeats.join(", "),
                              textAlign: TextAlign.right,
                              style: GoogleFonts.raleway(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Seat",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 180),
                          Text(
                            "Rp. 50.000 x ${widget.selectedSeats.length}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fees",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 180),
                          Text(
                            "Rp. 20.000 x ${widget.selectedSeats.length}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 195),
                          Text(
                            "Rp. ${formatCurrency(calculateTotal(widget.selectedSeats.length))}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                  thickness: 2,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Saldo Wallet",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Rp. ${formatCurrency(widget.saldo)}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, bottom: 40),
                      child: Text(
                        "Checkout Now",
                        style: GoogleFonts.raleway(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int totalCost =
                            calculateTotal(widget.selectedSeats.length);

                        if (widget.saldo >= totalCost) {
                          String id =
                              FirebaseAuth.instance.currentUser!.uid;
                          walletProvider.deductBalance(totalCost);
                          CollectionReference historiCheckCollection =
                              FirebaseFirestore.instance
                                  .collection('historyCheck');
                          Map<String, dynamic> checkoutData = {
                            'idCust': id,
                            'moviePoster': widget.movies.poster,
                            'orderId': generateOrderId(),
                            'movieTitle': widget.movies.judul,
                            'cinema': widget.namaBioskop,
                            'dateTime': '${widget.namaHari}, ${widget.namaJam}',
                            'selectedSeats': widget.selectedSeats,
                            'ticketPrice': 50000,
                            'feePrice': 20000,
                            'total': totalCost,
                          };
                          historiCheckCollection.add(checkoutData);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const success_checkout()));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const wallettopup()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 50, bottom: 40, left: 105),
                        child: Icon(
                          widget.saldo >=
                                  calculateTotal(widget.selectedSeats.length)
                              ? Icons.arrow_circle_right
                              : Icons.account_balance_wallet_rounded,
                          color: widget.saldo >=
                                  calculateTotal(widget.selectedSeats.length)
                              ? const Color(0xFFE1A20B)
                              : Colors.red,
                          size: widget.saldo >=
                                  calculateTotal(widget.selectedSeats.length)
                              ? 60
                              : 40,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk menghitung total berdasarkan jumlah kursi
int calculateTotal(int seatCount) {
  int ticketPrice = 50000;
  int feePrice = 20000;
  return (ticketPrice * seatCount) + (feePrice * seatCount);
}

// Fungsi untuk memformat mata uang
String formatCurrency(int amount) {
  final formatter = NumberFormat("#,###", "id_ID");
  return formatter.format(amount);
}
