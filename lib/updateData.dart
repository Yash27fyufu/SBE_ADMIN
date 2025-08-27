// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use, unnecessary_null_comparison, annotate_overrides, avoid_print

import 'dart:io';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'globalvar.dart';
import 'mainpage.dart';

class UpdateDetails extends StatefulWidget {
  UpdateDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  bool isChecked = false;
  List<String> files = [];
final formkey = GlobalKey<FormState>();

  void initState() {
    if (temp[0] == "yes") {
      toenable = true;
      updatepriceController.text = temp[4].toString();
      updatedescriptionController.text = temp[3].toString();
      isChecked = true;
      landingpg = "yes";
    }
    super.initState();
  }

  bool toenable = false;

  var updatepathController = TextEditingController()..text = pathxy;
  var updatecategoriesController = TextEditingController()..text = temp[1];

  var updatepriceController = TextEditingController();
  var updatedescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          pathxy = pathxy.substring(0, pathxy.lastIndexOf("/"));
          gotolastpage(context);
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Update Data"),
          ),
          body: SafeArea(
              child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Update Data",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: updatepathController,
                      enabled: false,
                      decoration: const InputDecoration(
                          label: Text("Path"), border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z ]")),
                      ],
                      controller: updatecategoriesController,
                      decoration: const InputDecoration(
                          label: Text("Categories/Models"),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Image :",
                          style: TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                fixedSize: const Size(120, 40)),
                            child: const Text(
                              "Camera",
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () => uploadImage(0)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                textStyle: TextStyle(
                                  color: Colors.black
                                ),
                                fixedSize: const Size(100,
                                    40) // put the width and height you want
                                ),
                            child: const Text("Gallery",
                                textAlign: TextAlign.center),
                            onPressed: () => uploadImage(1)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height / 7,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: pickedimgList.length,
                          itemBuilder: (BuildContext ctx, int indx) {
                            return pickedimgList.isEmpty
                                ? const Text("No Image",
                                    textAlign: TextAlign.center)
                                : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: pickedimgList[indx]
                                                      .toString()
                                                      .trim()
                                                      .substring(0, 4) ==
                                                  "http"
                                              ? Image.network(
                                                  pickedimgList[indx]
                                                      .toString()
                                                      .trim(),
                                                  fit: BoxFit.cover,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.file(
                                                    pickedimgList[indx],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 0, 0, 30),
                                              onPressed: () {
                                                setState(() {
                                                  {
                                                    if (indx <
                                                        alreadyimgcount) {
                                                      pickedimgList
                                                          .removeAt(indx);
                                                      alreadyimgcount--;
                                                    } else {
                                                      FirebaseStorage.instance
                                                          .refFromURL(
                                                              files[indx])
                                                          .delete();
                                                      files.removeAt(indx);
                                                    }
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 20,
                                              )),
                                        )
                                      ]);
                          }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              toenable = value;
                              if (value) {
                                landingpg = "yes";
                              } else {
                                landingpg = "no";
                              }
                            });
                          },
                          value: isChecked,
                        ),
                        const Text(
                          "Landing Page",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z\n\s., ]")),
                      ],
                      enabled: toenable,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: updatepriceController,
                      decoration: const InputDecoration(
                          label:
                              Text("Price"), // enable multi line text as input
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z\n\s., ]")),
                      ],
                      enabled: toenable,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: updatedescriptionController,
                      decoration: const InputDecoration(
                          label: Text(
                              "Description"), // enable multi line text as input
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (updatecategoriesController.text.isEmpty) {
                          return;
                        } else {
                          updatedata();
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          )),
        ));
  }

  @override
  void deactivate() {
    super.deactivate();
  }

 Future<void> uploadImage(int camnum) async {
  final pp = updatecategoriesController.text.trim();

  if (pp.isEmpty) {
    const snackBar = SnackBar(
      content: Text('Enter category name first'),
      duration: Duration(milliseconds: 500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;

  if (camnum == 0) {
    image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
  } else {
    image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
  }

  if (image == null) return; // ✅ user cancelled

  try {
    final file = File(image.path);
    files.add(image.path);

    final ref = FirebaseStorage.instance.ref().child(
      "${pathxy.substring(0, pathxy.lastIndexOf("/"))}/$pp/${image.name}",
    );

    final uploadTask = ref.putFile(file);

    uploadTask.whenComplete(() async {
      if (uploadTask.snapshot.state == TaskState.success) {
        final imageURL = await ref.getDownloadURL();
        pickedimgList.add(imageURL);
        setState(() {});
        print("✅ Image uploaded: $imageURL");
      }
    }).catchError((error) {
      print("❌ Upload failed: $error");
    });
  } on PlatformException catch (e) {
    print("❌ PlatformException: $e");
  }
}

  void updatedata() async {
    if (alreadyimgcount + files.length != pickedimgList.length) {
      const snackBar = SnackBar(
        content: Text('Wait for images to upload'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    temp[2].removeWhere((element) => pickedimgList.contains(element));

    for (var d in temp[2]) {
      if (d.toString().startsWith("http")) {
        FirebaseStorage.instance.refFromURL(d.toString().trim()).delete();
      }
    }

//above part filters the images which were deselected and delete from the storage

    pp = updatecategoriesController.text.toString().trim().toString();
    dynamic datax;

    var newadd = (pathxy.substring(0, pathxy.lastIndexOf("/") + 1)) +
        updatecategoriesController.text;

    database.child(pathxy).update({
      "images": pickedimgList.toString(),
      "lp": landingpg,
      "desc": updatedescriptionController.text.isEmpty
          ? null
          : updatedescriptionController.text.toString().trim(),
      "price": updatepriceController.text.isEmpty
          ? null
          : updatepriceController.text.toString().trim()
    });

    vehicleStream = database.child(pathxy).once().then((event) {
      datax = event.snapshot.value;
      if (datax != null) {
        database.child(newadd).set(datax);
      } else {
        return null;
      }
    });

    var temppath = pathxy;

    Future.delayed(const Duration(milliseconds: 5000), () {
      if (temppath.substring(temppath.lastIndexOf("/") + 1) != pp) {
        // if the category name is new then delete the old one after copying else just assign the values
        database.child(temppath).remove();
      }
    });

    updatedescriptionController.clear();
    updatecategoriesController.clear();
    updatepriceController.clear();

    final snackBar = SnackBar(
      content: const Text('Updated Data'),
      duration: new Duration(milliseconds: 500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    pathxy = "Home";

    pgtitle = "Home";

    // ignore: unnecessary_new
    var _timer = new Timer(const Duration(milliseconds: 1000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  title: pathxy,
                )),
      );
    });
  }
}
