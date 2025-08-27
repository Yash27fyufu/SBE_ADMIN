// ignore_for_file: unused_import, unused_local_variable, await_only_futures, unnecessary_new, deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:share_plus/share_plus.dart';

import 'globalvar.dart';
import 'mainpage.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MaterialApp(home: PDFViewpage()));
}

class PDFViewpage extends StatefulWidget {
  @override
  State<PDFViewpage> createState() => _PDFViewpageState();
}

class _PDFViewpageState extends State<PDFViewpage> {
  late String basePath;

  @override
  void initState() {
    super.initState();
    filenameinurl = pdfurl.toString().substring(
        pdfurl.toString().lastIndexOf("%2F") + 3,
        pdfurl.toString().lastIndexOf("?alt="));
    asd = pathxy.toString().replaceAll("/", "");
    asd = asd.toString().replaceAll(" ", "");

    isloadin = true;

    _initPathAndDownload();
  }

  Future<void> _initPathAndDownload() async {
    final dir = await getApplicationDocumentsDirectory();
    basePath = "${dir.path}/SBE";
    await downloadfile();
  }

  @override
  Widget build(BuildContext context) {
    String pdfpagetitle = "View PDF";
    pdfpagetitle = pgtitle.toString();

    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      title: pgtitle,
                    )),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(pdfpagetitle),
              backgroundColor: Colors.amber,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      sharefile(asd);
                    },
                  ),
                ),
              ],
            ),
            body: Container(
                child: isloadin
                    ? const Center(child: CircularProgressIndicator())
                    : PDF().fromPath(
                        "$basePath/$asd/$filenameinurl.pdf"))));
  }

  Future<void> downloadfile() async {
    setState(() {
      isloadin = true;
    });

    final dir = Directory(basePath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final subDir = Directory("$basePath/$asd");
    if (!await subDir.exists()) {
      await subDir.create(recursive: true);
      await savethepdfindevice(asd);
    } else {
      setState(() {
        isloadin = false;
      });

      var filesinfolder = "";
      var filenameindevice = "";
      if (subDir.listSync(recursive: true, followLinks: false).isNotEmpty) {
        filesinfolder = subDir.listSync(recursive: true, followLinks: false)[0]
            .toString();
        filenameindevice = filesinfolder.substring(
            filesinfolder.lastIndexOf("/") + 1, filesinfolder.length - 5);
      }

      if (filenameindevice.toString() == "") {
        await savethepdfindevice(asd);
      } else if (filenameindevice != filenameinurl) {
        deleteFile(File(
            filesinfolder.toString().substring(7, filesinfolder.length - 1)));
        await savethepdfindevice(asd);
      }
    }
  }

  Future<void> savethepdfindevice(asd) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(pdfurl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    File file = File("$basePath/$asd/$filenameinurl.pdf");
    await file.writeAsBytes(bytes);

    setState(() {
      isloadin = false;
    });
  }

  sharefile(asd) async {
    await Share.shareXFiles(
      [XFile("$basePath/$asd/$filenameinurl.pdf")],
    );
  }
}
