// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_collection_literals, unused_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'feedback.dart';
import 'tnc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

var tempgstnum = "",
    tempaddress = "",
    templorry = "",
    tempshopame = "",
    tempphonenum = "",
    temporder = "";

var issearchon = false;
var pathxy = "Home";
var pgtitle = "Home";
var landingpg;
var alreadyimgcount = 0;
var isloadin = false;
var deletingdata = false;
var globalBucket = PageStorageBucket();
var desc, price, pdfurl;
var filenameinurl;
var asd;
List temptempforsearch = [], tempimgforsearch = [];

List img = [];
List categories = [];
List pickedimgList = [];
int count = 0;
dynamic images = [];
List names = [];
List temp = [];
var database = FirebaseDatabase.instance.ref();
var vehicleStream;
Map<String, List> dummy = {};
var imgstorage = FirebaseStorage.instance;
var pp;
var abtpgdetails = [];
List phonenumbers = [];
var smap = Map<String, String>();
var smapkeys = [];
var smapval = [];
var storageImages = [];
var pdfflag = false;
var document;
var noimglink =
    "https://media.istockphoto.com/vectors/black-linear-photo-camera-like-no-image-available-vector-id1055079680?k=20&m=1055079680&s=612x612&w=0&h=ujFxkvnp-VclErGByAsr2RYLJObedAtK7NNLgNJY_8A=";

Future<void> getimgurl(String pathforimg) async {
  final FirebaseStorage storage = FirebaseStorage.instance;

  final result = await storage.ref(pathforimg).list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();

    storageImages.add(fileUrl);
  });
}

gotolastpage(var context) {
  pgtitle = pathxy;
  if (pathxy != "Home") {
    pgtitle = pathxy.substring(pathxy.lastIndexOf("/") + 1);
  }

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => Home(
              title: pgtitle,
            )),
  );
}

delete_images_from_db_which_are_not_used() {
  if (temp[2] == []) return;

  temp[2].removeWhere((element) => pickedimgList.contains(element));

  for (var xy in temp[2]) {
    FirebaseStorage.instance.refFromURL(xy.toString().trim()).delete();
  } // deletes the images from database which are deselected from the list
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

    // for (var mx in abtpgdetails[3]) {
    //   if (mx == "") continue;
    //   img.add(mx);
    // }
    for (var mx in abtpgdetails[2]) {
      if (mx == "") continue;
      phonenumbers.add(mx);
    }
  });
}

readalldata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("shopname") != null) {
    tempshopame = prefs.getString("shopname")!;
  }

  if (prefs.getString("address") != null) {
    tempaddress = prefs.getString("address")!;
  }

  if (prefs.getString("lorry") != null) {
    templorry = prefs.getString("lorry")!;
  }

  if (prefs.getString("phonenum") != null) {
    tempphonenum = prefs.getString("phonenum")!;
  }

  if (prefs.getString("gstnum") != null) {
    tempgstnum = prefs.getString("gstnum")!;
  }

  if (prefs.getString("order") != null) {
    temporder = prefs.getString("order")!;
  }
}

Future<void> deleteFile(File file) async {
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {}
}
