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
import 'package:intl/intl.dart';

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
      categories[0]["images"] = categories[0]["images"]
          .toString()
          .substring(1, categories[0]["images"].toString().length - 1);

      categories[0]["images"] = categories[0]["images"].toString().split(",");

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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        fixedSize: const Size(140, double.infinity),
                      ),
                      child: const Text(
                        "Upload PDF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () => {uploadpdffiles()}),
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
                              "Delete PDF",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => {deletespdffile()}),
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
                                      top: 5, bottom: 15, left: 12, right: 12),
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

  Future<void> uploadpdffiles() async {
    try {
      // 1. Let the user pick a new file
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      // 2. Handle user cancellation
      if (result == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File selection cancelled.'),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
        return;
      }

      // 3. Get a reference to the folder you want to delete
      final folderRef = FirebaseStorage.instance.ref().child("PDF/$pathxy");

      // 4. List and delete all existing files in the folder
      final ListResult listResult = await folderRef.listAll();

      // Check for any prefixes (subfolders) to delete as well
      for (var prefix in listResult.prefixes) {
        // You may need to call this function recursively to delete subfolders
        // For this example, we assume no subfolders exist.
      }

      // Loop through all items and delete them one by one
      for (var item in listResult.items) {
        await item.delete();
      }

      // Optionally, update the database to clear the old URL
      await database.child(pathxy).update({"pdf": null});

      // 5. Generate a unique timestamp for the new file name
      final now = DateTime.now();
      final formatter = DateFormat('yyyyMMdd_HHmmss');
      final timestamp = formatter.format(now);
      final fileName = 'PDF_$timestamp.pdf';

      // 6. Upload the new file to the now-empty folder
      final file = File(result.files.first.path!);
      final newFileRef =
          FirebaseStorage.instance.ref().child("PDF/$pathxy/$fileName");
      final uploadTask = newFileRef.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask;
      if (taskSnapshot.state == TaskState.success) {
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // 7. Update the database with the new file URL
        await database.child(pathxy).update({"pdf": downloadUrl});

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File Uploaded Successfully!'),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      }

      // 8. Navigate after a successful operation
      if (context.mounted) {
        // pgtitle = "Home";
        // pathxy = "Home";
        // // ⚠️ Change from Navigator.push to Navigator.pushReplacement
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home(title: pgtitle)),
        // );

        check_for_pdf();
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Firebase Error: ${e.message}'),
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unknown error occurred: $e'),
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
    }
  }

  deletespdffile() async {
    if (pdfurl == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No PDF file to delete.'),
            duration: Duration(milliseconds: 1500),
          ),
        );
      }
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete PDF"),
          content: const Text("Are you sure you want to delete this PDF?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                await deletepdffile(); // Call the actual delete function
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

// Your existing deletepdffile() function (no changes needed here)
  Future<void> deletepdffile() async {
    if (pdfurl == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No PDF file to delete.'),
            duration: Duration(milliseconds: 1500),
          ),
        );
      }
      return;
    }

    try {
      final storageRef = FirebaseStorage.instance.refFromURL(pdfurl);
      await storageRef.delete();

      await database.child(pathxy).update({"pdf": null});

      check_for_pdf();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF file deleted successfully!'),
            duration: Duration(milliseconds: 1500),
          ),
        );
      }
        if (context.mounted) {
        // pgtitle = "Home";
        // pathxy = "Home";
        // // ⚠️ Change from Navigator.push to Navigator.pushReplacement
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home(title: pgtitle)),
        // );

        check_for_pdf();
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Firebase Error: ${e.message}'),
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unknown error occurred: $e'),
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
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
        } else {
          pdfflag = false;
          setState(() {});
        }
      });
    } catch (e) {
      pdfflag = false;
      setState(() {});
    }
  }
}
