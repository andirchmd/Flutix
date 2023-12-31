// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutixapp/ui/pages/home/successtopup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class wallettopup extends StatefulWidget {
  const wallettopup({Key? key}) : super(key: key);

  @override
  State<wallettopup> createState() => _wallettopupState();
}

class _wallettopupState extends State<wallettopup> {
  final TextEditingController _controller = TextEditingController();
  int currentBalance = 0;
  
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    List<String> template = [
      "50.000",
      "100.000",
      "150.000",
      "200.000",
      "500.000",
      "1.000.000"
    ];
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
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Top Up",
            style: GoogleFonts.raleway(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
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
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amount",
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1),
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.black),
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "IDR",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 208, 165, 203),
                                width: 1,
                              )),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              labelStyle: GoogleFonts.raleway(
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          "Choose by template",
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      // ListView.builder untuk menampilkan daftar template
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: template.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: GestureDetector(
                              onTap: () {
                                _controller.text = template[index];
                              },
                              child: Container(
                                height: 60,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: _controller.text == template[index]
                                      ? Colors
                                          .black // Ubah warna jika template dipilih
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "IDR",
                                      style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      template[index],
                                      style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            int templateValue = int.tryParse(
                                    _controller.text.replaceAll(".", "")) ??
                                0;
                            int newTopUpAmount = templateValue;

                            // int updatedBalance = currentBalance + newTopUpAmount;

                            // Update the currentBalance with the new total
                            setState(() {
                              currentBalance += newTopUpAmount;
                            });

                            print("New Balance: $currentBalance");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    successtopup(currentBalance),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0x000007fd),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(200, 50),
                          ),
                          child: Text(
                            "Top Up My Wallet",
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}