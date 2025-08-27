
import 'feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aboutPage.dart';
import 'globalvar.dart';
import 'mainpage.dart';
import 'noteorder.dart';

class Tnc extends StatelessWidget {
  const Tnc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          pathxy = "Home";
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      title: "Home",
                    )),
          );
          return false;
        },
        child: Scaffold(
            drawer: Drawer(
            backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 105,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'SHRI BALAJI ENTERPRISES',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 0),
                    dense: true,
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      pgtitle = "Home";
                      pathxy = "Home";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  title: pgtitle,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 0),
                    dense: true,
                    title: Text(
                      'Order',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      readalldata();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NoteOrder()),
                      );
                    },
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 0),
                    dense: true,
                    title: Text(
                      'About Us',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 440,
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 0),
                    tileColor: Colors.grey[350],
                    dense: true,
                    title: Text(
                      "Terms of Use",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Tnc()),
                      );
                    },
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 0),
                    dense: true,
                    title: Text(
                      "Contact Developer",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text(
                "Terms of Use",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(
                          top: 25, left: 15, right: 15, bottom: 60),
                      child: const Text(
                        "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tOwnership of content" +
                            "\n\n\t\t\t\t\t\tHost acknowledges that its use of the Content and the Trademarks as herein provided shall not create any right, title and interest therein in Host's favor. Host further agrees not to copy, reproduce, sell, license, subscribe, lease, distribute, disseminate, broadcast, webcast or otherwise use the Content or portions thereof other than as expressly permitted herein." +
                            "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\tRight to change any time" +
                            "\n\n \t\t\t\tPrices (provided by way of a Quotation or a Price List) are subject to change to the prices in effect at the time of delivery. Seller reserves the right to make any corrections to prices quoted due to clerical errors or errors of omission. In the event of any specific requirements (including without limitation any design, specification, ordered quantity, or shipment changes) representing a price increase, Buyer will be notified and afforded an opportunity to confirm" +
                            "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tProhibited uses" +
                            "\n\n\t\t\t\t\t You may not do (or permit others to do) any of the following: (a) modify, adapt, alter, translate, or create derivative works of the Software; (b) assign, distribute, lease, sublicense or otherwise transfer the Software or any rights under this Agreement, to any other party; (c) merge or otherwise integrate the Software with any external components or other software except as expressly permitted under this Agreement; (d) reverse engineer, decompile, or disassemble the Software, or otherwise attempt to derive the source code of the Software except and only to the extent that such activity is expressly permitted by applicable law notwithstanding this limitation; (e) remove, alter, or obscure any confidentiality or proprietary notices (including copyright and trademark notices) of Software FX or its suppliers on the Software, including any copies of the Software that you are permitted to make under this Agreement; (f) make the Design-time Components and/or Production Server Components available to others on a hosted, time-sharing, ASP or other basis; (g) use the Design-time Components to generate reports on a on a production basis; (h) circumvent, or provide or use a program intended to circumvent, technological measures (such as activation codes) that control installation or use of the Software" +
                            "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tLiability disclaimers" +
                            "\n\n\t\t\t\t\tThe author assumes no responsibility or liability for any errors or omissions in the content of this site. The information contained in this site is provided on an \"as is\" basis with no guarantees of completeness, accuracy, usefulness or timeliness.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
            )));
  }
}
