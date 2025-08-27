// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ShowFullmages extends StatelessWidget {
  ShowFullmages({Key? key, required this.url}) : super(key: key);
  String url;
  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: NetworkImage(url));
  }
}
