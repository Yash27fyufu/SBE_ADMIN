// ignore_for_file: unused_import, unused_local_variable, await_only_futures, unnecessary_new, deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:share_plus/share_plus.dart';

import 'globalvar.dart';
import 'mainpage.dart';
// import 'package:permission_handler/permission_handler';

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
  double _downloadProgress = 0.0; // Added for download progress

  @override
  void initState() {
    super.initState();
    filenameinurl = pdfurl.toString().substring(
        pdfurl.toString().lastIndexOf("%2F") + 3,
        pdfurl.toString().lastIndexOf("?alt="));
    asd = pathxy.toString().replaceAll("/", "");
    asd = asd.toString().replaceAll(" ", "");

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
        // Prevent back navigation if the file is still loading
        if (isloadin) {
          return false;
        }

        // Allow back navigation and go to the home page if not loading
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              title: pgtitle,
            ),
          ),
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
                  if (!isloadin) {
                    sharefile(asd);
                  }
                },
              ),
            ),
          ],
        ),
        body: Container(
          child: isloadin
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        "Downloading: ${(_downloadProgress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : PDF().fromPath("$basePath/$asd/$filenameinurl.pdf"),
        ),
      ),
    );
  }

  Future<void> downloadfile() async {
    setState(() {
      isloadin = true;
      _downloadProgress = 0.0;
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
      final file = File("$basePath/$asd/$filenameinurl.pdf");
      if (await file.exists()) {
        setState(() {
          isloadin = false;
        });
      } else {
        await savethepdfindevice(asd);
      }
    }
  }

  Future<void> savethepdfindevice(asd) async {
    try {
      final request = await HttpClient().getUrl(Uri.parse(pdfurl));
      final response = await request.close();
      final totalBytes = response.contentLength;

      final file = File("$basePath/$asd/$filenameinurl.pdf");
      final sink = file.openSync(mode: FileMode.write);
      int bytesReceived = 0;

      await for (var chunk in response) {
        sink.writeFromSync(chunk);
        bytesReceived += chunk.length;

        setState(() {
          if (totalBytes != -1) {
            _downloadProgress = bytesReceived / totalBytes;
          }
        });
      }
      await sink.close();
    } catch (e) {
      print("Error saving PDF: $e");
    } finally {
      setState(() {
        isloadin = false;
      });
    }
  }

  sharefile(asd) async {
    await Share.shareXFiles(
      [XFile("$basePath/$asd/$filenameinurl.pdf")],
    );
  }
}