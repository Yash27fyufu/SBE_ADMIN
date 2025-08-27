// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, deprecated_member_use

import 'dart:io';

// import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'pdfview.dart';
import 'mainpage.dart';
import 'noteorder.dart';
import 'showFullImage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart'; // ✅ added

import 'globalvar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int activeIndex = 0;

  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();
    getabtpgdetails();

    pdfflag = false;
    check_for_pdf();

    {
      categories[0]["images"] = categories[0]["images"].toString().substring(
          1, categories[0]["images"].toString().length - 1);

      categories[0]["images"] =
          categories[0]["images"].toString().split(",");

      img.clear();
      for (var mx in categories[0]["images"]) {
        if (mx == "") continue;
        img.add(mx.toString().trim());
      }
    }
    if (img.isEmpty) {
      img.add(noimglink);
    }
    controller = TransformationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var sdf = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    price = categories[0]["price"] == null
        ? "Contact for price details"
        : categories[0]["price"].toString();
    desc =
        categories[0]["desc"] == null ? "" : categories[0]["desc"].toString();

    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider.builder(
                      itemCount: img.length,
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height - 650,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: img.length == 1 ? false : true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() => activeIndex = index);
                          }),
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowFullmages(
                                        url: img[index],
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color:
                                  img[index] == noimglink ? null : Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(img[index]),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                !pdfflag
                    ? const SizedBox()
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              fixedSize: const Size(140, double.infinity),
                            ),
                            child: const Text(
                              "View PDF",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => {getFirebaseImageFolder()}),
                      ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        fixedSize: const Size(140, double.infinity),
                      ),
                      child: const Text(
                        "Note Order",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        readalldata();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteOrder()));
                      }),
                ),
                Container(
                  child: desc == ""
                      ? null
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 20),
                            child: Scrollbar(
                              controller:
                                  ScrollController(initialScrollOffset: 0),
                              child: SingleChildScrollView(
                                controller:
                                    ScrollController(initialScrollOffset: 0),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Text(desc.toString(),
                                      style: const TextStyle(fontSize: 18)),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                Container(
                  child: price == ""
                      ? null
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 22, right: 20, bottom: 20),
                            child: Scrollbar(
                              thumbVisibility: true,
                              controller: sdf,
                              child: SingleChildScrollView(
                                controller: sdf,
                                child: Container(
                                  width: 2000,
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 15,
                                      left: 12,
                                      right: 12),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: GestureDetector(
                                    onTap: () {
                                      UrlLauncher.launch(
                                          "tel://${phonenumbers[0]}");
                                    },
                                    child: Text(
                                      price.toString(),
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String sd = "";

  void getFirebaseImageFolder() async {
    try {
      downloadpdffile();
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('No PDF found'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  uploadpdffiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      var storageRef = FirebaseStorage.instance
          .ref()
          .child("PDF/$pathxy/${sd.toString().replaceAll("/", "")}1");
      pdfurl = await storageRef.getDownloadURL();

      FirebaseStorage.instance.refFromURL(pdfurl).delete();
      database.child(pathxy).update({"pdf": null});
      pgtitle = "Home";
      pathxy = "Home";
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  title: pgtitle,
                )),
      );
      return;
    }
    sd = result.files.first.path.toString();

    if (sd.substring(sd.lastIndexOf(".") + 1) == "pdf") {
      var file = File(sd);
      final ref = FirebaseStorage.instance.ref().child("PDF/$pathxy/1");

      ref.putFile(file).then((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            database.child(pathxy).update({"pdf": imageURL});

            const snackBar = SnackBar(
              content: Text('File Uploaded'),
              duration: Duration(milliseconds: 500),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            pgtitle = "Home";
            pathxy = "Home";
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        title: pgtitle,
                      )),
            );
          });
        }
      });
    }
  }

  downloadpdffile() async {
    final dir = await getApplicationDocumentsDirectory(); // ✅ use common path
    final commonPath = "${dir.path}/SBE";

    // Ensure directory exists
    if (!await Directory(commonPath).exists()) {
      await Directory(commonPath).create(recursive: true);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewpage(),
      ),
    );
  }

  void check_for_pdf() async {
    try {
      vehicleStream = database.child(pathxy).once().then((event) async {
        pdfurl = event.snapshot.child("pdf").value;
        if (pdfurl != null) {
          pdfflag = true;
          setState(() {});
        }
      });
    } catch (e) {
      pdfflag = false;
      setState(() {});
    }
  }
}
