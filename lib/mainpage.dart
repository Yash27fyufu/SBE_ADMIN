// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_contains, prefer_typing_uninitialized_variables, await_only_futures, avoid_unnecessary_containers, deprecated_member_use, unnecessary_import

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:new_version_plus/new_version_plus.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'addDetails.dart';
import 'noteorder.dart';

import 'aboutPage.dart';
import 'globalvar.dart';
import 'tnc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'feedback.dart';
import 'gridwidget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'landingpage.dart';
import 'updateappdialog.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String title;

  Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  final database = FirebaseDatabase.instance.ref();
  bool isSelected = true;
  final searchtext = TextEditingController();

  var focussearchbar = FocusNode();

  @override
  void initState() {
    super.initState();
    _checkVersion2();
    activateListeners(pathxy);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pathxy == "Home") {
          if (issearchon) {
            issearchon = false;
            setState(() {
              temp.clear();
              img.clear();

              for (int i = 0; i < temptempforsearch.length; i++) {
                temp.add(temptempforsearch[i]);
                img.add(tempimgforsearch[i]);
              }
              temptempforsearch.clear();
              tempimgforsearch.clear();
              searchtext.clear();
              issearchon = false;
            });
            return false;
          }else{
          return false;
          }
        }

        pathxy = pathxy.substring(0, pathxy.lastIndexOf("/"));
        gotolastpage(context);
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
                visualDensity: VisualDensity(vertical: 0),
                dense: true,
                tileColor: Colors.grey[350],
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;
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
                title: Text(
                  'Order',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;

                  readalldata();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoteOrder()),
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
                  issearchon = false;

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
                  issearchon = false;

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
                  issearchon = false;

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
        appBar: issearchon && landingpg != "yes"
            ? AppBar(
                title: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Color.fromARGB(0, 255, 255, 255), width: 0.0),
                              ),
                            ),
                            focusNode: focussearchbar,
                            autofocus: true,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: searchtext,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              temp.clear();
                              img.clear();

                              for (int i = 0;
                                  i < temptempforsearch.length;
                                  i++) {
                                if (value == '') {
                                  for (int i = 0;
                                      i < temptempforsearch.length;
                                      i++) {
                                    temp.add(temptempforsearch[i]);
                                    img.add(tempimgforsearch[i]);
                                  }
                                  break;
                                } else {
                                  if (temptempforsearch[i]
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          value.toString().toLowerCase())) {
                                    temp.add(temptempforsearch[i]);
                                    img.add(tempimgforsearch[i]);
                                  }
                                }
                              }
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                temp.clear();
                                img.clear();

                                for (int i = 0;
                                    i < temptempforsearch.length;
                                    i++) {
                                  temp.add(temptempforsearch[i]);
                                  img.add(tempimgforsearch[i]);
                                }
                                temptempforsearch.clear();
                                tempimgforsearch.clear();
                                searchtext.clear();
                                issearchon = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            :AppBar(
                actions: <Widget>[
                  if (landingpg != "yes")
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        // do something
                        issearchon = true;
                        tempimgforsearch.clear();
                        temptempforsearch.clear();

                        for (int i = 0; i < temp.length; i++) {
                          temptempforsearch.add(temp[i]);
                          tempimgforsearch.add(img[i]);
                        }
                        setState(() {});
                        focussearchbar.requestFocus();
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: landingpg == "yes"
                        ? null
                        : MaterialButton(
                            minWidth: 100,
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              }
                            },
                            child: isSelected
                                ? const Text(
                                    "Edit is off",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 203, 19, 19),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    "Edit is on",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                  ),
                ],
                title: Text(
                  pgtitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
         body: categories.isEmpty
            ? const Align(
                alignment: Alignment.center,
                child: Text(
                  "No Data Found",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            : landingpg == "yes"
                ? LandingPage()
                : PageStorage(
                    bucket: globalBucket,
                    key: const PageStorageKey(0),
                    child: GridWidget(
                      length: temp.length,
                      text: temp,
                      acti: activateListeners,
                      isSelected: isSelected,
                    ),
                  ),
                   floatingActionButton: landingpg == "yes"
            ? null
            : FloatingActionButton(
              backgroundColor: Colors.amber,
                child: const Icon(Icons.add),
                onPressed: () {
                  pickedimgList.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDetails()),
                  );
                },
              ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> activateListeners(String x) async {
    categories.clear();
    img.clear();

    vehicleStream = database.child(x).once().then((event) async {
      dynamic data = event.snapshot.value;

      temp = [];

      landingpg = await event.snapshot.child("lp").value;

      if (landingpg == "yes") {
        temp.add(event.snapshot.value);
      } else {
        data.forEach((k, v) async {
          if (k != "lp" &&
              k != "desc" &&
              k != "price" &&
              k != "images" &&
              k != "pdf") {
            if (k != "images") {
              temp.add(k);
            }
            if (event.snapshot.child(k).child("images").value == "[]") {
              img.add(noimglink);
            } else {
              img.add(event.snapshot
                  .child(k)
                  .child("images")
                  .value
                  .toString()
                  .substring(
                      1,
                      event.snapshot
                                  .child(k)
                                  .child("images")
                                  .value
                                  .toString()
                                  .indexOf(",") ==
                              -1
                          ? event.snapshot
                                  .child(k)
                                  .child("images")
                                  .value
                                  .toString()
                                  .length -
                              1
                          : event.snapshot
                              .child(k)
                              .child("images")
                              .value
                              .toString()
                              .indexOf(",")));
            }
          }
        });
        bool isSwapped = false;
        do {
          isSwapped = false;
          for (int i = 0; i < temp.length - 1; i++) {
            if (temp[i].compareTo(temp[i + 1]) > 0) {
              String tr = temp[i + 1];
              temp[i + 1] = temp[i];
              temp[i] = tr;
              isSwapped = true;
              //sort the images along with the category names
              String imgtr = img[i + 1];
              img[i + 1] = img[i];
              img[i] = imgtr;
            }
          }
        } while ((isSwapped));
      }
      setState(() {
        img = img;
        categories = temp;
      });

      setState(() {});
    });
  }

  void _checkVersion2() async {
    final newVersion = NewVersionPlus(
      iOSId: 'com.latest.sbe.catalogue',
      androidId: 'com.latest.sbe.catalogue',
    );

    final status = await newVersion.getVersionStatus();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var onlinepackageinfo;

    vehicleStream = database.child("UpdateDetails").once().then((event) {
      dynamic data = event.snapshot.value;
      onlinepackageinfo = data["Packageversion"].toString();

      if (status!.canUpdate ||
          packageInfo.version.compareTo(onlinepackageinfo) == -1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              allowDismissal: true,
              description: status.releaseNotes!,
              version: status.storeVersion,
              appLink: status.appStoreLink,
            );
          },
        );
      }
    });
  }
}



//shribalajienterprises2006@gmail.com
//address old no.3 new no.5
//044-2538 6153
//9840628674
//A2Z PLUMBING SOLUTION