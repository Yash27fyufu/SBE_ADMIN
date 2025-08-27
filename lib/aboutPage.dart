// ignore_for_file: prefer_collection_literals, import_of_legacy_library_into_null_safe, library_prefixes, prefer_final_fields, file_names, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'feedback.dart';
import 'globalvar.dart';
import 'noteorder.dart';
import 'showFullImage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:label_marker/label_marker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mainpage.dart';
import 'tnc.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int activeIndex = 0;

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(13.090041991532244, 80.28658581252913), zoom: 17);
  GoogleMapController? _googlecontroller;
  Set<Marker> _markers = {};

  @override
  void dispose() {
    _googlecontroller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _markers.addLabelMarker(LabelMarker(
        label: "Click me to find the route",
        markerId: const MarkerId("1"),
        position: const LatLng(13.089846455861958, 80.28667655856152)));

    getabtpgdetails();
  }

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
                tileColor: Colors.grey[350],
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
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 440,
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: 0),
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
            "About Us",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'A2Z PLUMBING SOLUTIONS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: img.isEmpty
                      ? null
                      : CarouselSlider.builder(
                          itemCount: img.length,
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height - 550,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll:
                                  img.length == 1 ? false : true,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: abtpgdetails.isEmpty
                    ? null
                    : Column(
                        children: [
                          Text(
                            abtpgdetails[4].toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            abtpgdetails[0].toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              scrollDirection: Axis.horizontal,
                              child: GestureDetector(
                                onTap: () {
                                  sendmail();
                                },
                                child: Text(
                                  abtpgdetails[1],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  UrlLauncher.launch(
                                      "tel://${phonenumbers[index]}");
                                },
                                child: Text(
                                  phonenumbers[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: phonenumbers.length,
                          ),
                        ],
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                color: Colors.blueGrey[700],
                height: MediaQuery.of(context).size.height * 1 / 2 - 50,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) =>
                          _googlecontroller = controller,
                      markers: _markers,
                      initialCameraPosition: _initialCameraPosition,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer())),
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        child: FloatingActionButton(
                          onPressed: () => _googlecontroller?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                  _initialCameraPosition)),
                          mini: true,
                          child: const Icon(
                            Icons.center_focus_strong,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 105,
              )
            ],
          ),
        ),
      ),
    );
  }

  sendmail() async {
    String email = Uri.encodeComponent(abtpgdetails[1]);
    String subject = Uri.encodeComponent("Interested in your products - Reg.");
    String body = "I would like to contact you ";

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

  void getabtpgdetails() {
    abtpgdetails.clear();
    img.clear();
    phonenumbers.clear();

    vehicleStream = database.child("AboutPageDetails").once().then((event) {
      dynamic data = event.snapshot.value;

      abtpgdetails.add(data["Address"]);
      abtpgdetails.add(data["Mail"]);
      abtpgdetails.add(data["Phonenumber"]);

      abtpgdetails.add(data["Images"]);
      abtpgdetails.add(data["Name"]);

      abtpgdetails[3] = abtpgdetails[3].toString().split(","); // split the urls

      abtpgdetails[2] =
          abtpgdetails[2].toString().split(","); // split the phone numbers

      for (var mx in abtpgdetails[3]) {
        if (mx == "") continue;
        img.add(mx);
      }
      for (var mx in abtpgdetails[2]) {
        if (mx == "") continue;
        phonenumbers.add(mx);
      }

      setState(() {});
    });
  }
}
