// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aboutPage.dart';
import 'feedback.dart';
import 'globalvar.dart';
import 'mainpage.dart';
import 'tnc.dart';

class NoteOrder extends StatefulWidget {
  const NoteOrder({Key? key}) : super(key: key);

  @override
  State<NoteOrder> createState() => _NoteOrderState();
}

class _NoteOrderState extends State<NoteOrder> {
  @override
  void initState() {
    super.initState();
    //readfiles();
  }

  var shopname = TextEditingController(text: tempshopame);
  var contactnumber = TextEditingController(text: tempphonenum);
  var gstnumber = TextEditingController(text: tempgstnum);
  var address = TextEditingController(text: tempaddress);
  var lorry = TextEditingController(text: templorry);
  var writtenorder = TextEditingController(text: temporder);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          pathxy = "Home";
          pgtitle = "Home";
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
          backgroundColor: Colors.white,
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
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
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  tileColor: Colors.grey[350],
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
                      MaterialPageRoute(
                          builder: (context) => const NoteOrder()),
                    );
                  },
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
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
                  visualDensity: VisualDensity(vertical: 0),
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
                  visualDensity: VisualDensity(vertical: 0),
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
              "Order",
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
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              tempshopame = value;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("shopname", value);
                            },
                            controller: shopname,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Shop Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("phonenum", value);
                              tempphonenum = value;
                            },
                            controller: contactnumber,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9, \\- ]")),
                            ],
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Contact Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("gstnum", value);
                              tempgstnum = value;
                            },
                            controller: gstnumber,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("GST Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("address", value);
                              tempaddress = value;
                            },
                            minLines: 1,
                            maxLines: 5,
                            controller: address,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Address"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("lorry", value);
                              templorry = value;
                            },
                            minLines: 1,
                            maxLines: 5,
                            controller: lorry,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Lorry Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("order", value);
                              temporder = value;
                            },
                            minLines: 5,
                            maxLines: 10,
                            textAlign: TextAlign.justify,
                            controller: writtenorder,
                            decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15), // add padding to adjust icon
                                  child: IconButton(
                                    iconSize: 40,
                                    icon: const Icon(Icons.close),
                                    onPressed: () async {
                                      temporder = "";
                                      writtenorder.clear();

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString("order", "");
                                    },
                                  ),
                                ),
                                alignLabelWithHint: true,
                                label: Text("Write your order here..."),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              fixedSize: const Size(200, 40)),
                          child: Wrap(children: const <Widget>[
                            Text(
                              "Send Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ]),
                          onPressed: () => sendmail(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  sendmail() async {
    await createpdf();
  }

  Future<void> createpdf() async {
    temporder = temporder.trim();

    if (temporder.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter your order'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (tempshopame.trim().isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter your Shop name'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (tempphonenum.trim().isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter your Phone number'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (tempgstnum.trim().isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter your GST number'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (tempaddress.trim().isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter your Address'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    var numoflines = "\n".allMatches(temporder).length;
    List temptemporder = [];
    var numofpdfpages = ((numoflines + (temporder.length / 32)) / 18).ceil();

    temporder = temporder.replaceAll("\n", "                                ");

    for (int i = 0; i < numofpdfpages; i++) {
      temptemporder.add("");
      for (int j = 576 * i;
          j < (576 * (numofpdfpages + 1)) && j < temporder.length;
          j++) {
        temptemporder[i] += temporder[j];
      }
      temptemporder[i] =
          temptemporder[i].replaceAll("                                ", "\n");
    }

    final pdf = pw.Document();
    for (int i = 0; i < numofpdfpages; i++) {
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Container(
            height: 1000,
            child: pw.Column(children: [
              pw.Text(
                tempshopame.toUpperCase(),
                style:
                    pw.TextStyle(fontSize: 35, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text("Ph.No:$tempphonenum", style: pw.TextStyle(fontSize: 22)),
              pw.Text("Address:$tempaddress",
                  style: pw.TextStyle(fontSize: 22)),
              if (templorry.trim().isNotEmpty)
                pw.Text("Lorry:$templorry", style: pw.TextStyle(fontSize: 18)),
              pw.Container(
                  width: 600,
                  child: pw.Row(children: [
                    pw.Text("GSTin:${tempgstnum.toUpperCase()}",
                        style: pw.TextStyle(fontSize: 22)),
                    pw.Spacer(),
                    pw.Container(
                        margin: pw.EdgeInsets.only(right: 10),
                        child: pw.Text("Page:${i + 1}",
                            style: pw.TextStyle(fontSize: 15))),
                  ])),
              pw.Container(height: 2, color: PdfColors.black),
              pw.SizedBox(height: 20),
              pw.Container(
                  margin: pw.EdgeInsets.only(left: 20, right: 20),
                  height: 500,
                  width: 700,
                  child: pw.Text(temptemporder[i],
                      style: pw.TextStyle(fontSize: 25),
                      textAlign: pw.TextAlign.justify)),
            ]));
      }));
    }

    // ✅ Use app documents directory (no permission needed, persistent until uninstall)
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Order.pdf');
    await file.writeAsBytes(await pdf.save());

    if (await file.exists()) {
      await Share.shareXFiles(
        [XFile(file.path)],
        text: "I would like to place an order",
      );
    }
  }
}
