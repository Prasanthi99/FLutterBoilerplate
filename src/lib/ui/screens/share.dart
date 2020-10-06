import 'dart:io';

import 'package:flutter/material.dart';
import 'package:boilerplate/services/device/deeplink_service.dart';
import 'package:image_picker/image_picker.dart' as image_picker;

class Share extends StatefulWidget {
  List<image_picker.PickedFile> images = new List<image_picker.PickedFile>();
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  TextEditingController _shareTextController =
      new TextEditingController(text: "Testing");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Share with your friends")),
            body: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Content",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16, height: 1.5)),
                      TextField(controller: _shareTextController),
                      SizedBox(height: 16),
                      Text("Images",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      SizedBox(height: 6),
                      captureImages(),
                      SizedBox(height: 20),
                      RaisedButton(
                          onPressed: () {
                            DeeplinkService.share(
                                title:
                                    "Tell your friends about this application",
                                text: _shareTextController.text,
                                subj: "Share",
                                files:
                                    widget.images.map((e) => e.path).toList());
                          },
                          child: Text("Share",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ]))));
  }

  captureImages() {
    List<Widget> list = new List<Widget>();
    if (widget.images != null) {
      if (widget.images != null && widget.images.length > 0) {
        widget.images.forEach((image) {
          if (image.path.isNotEmpty) {}
          list.add(new Image.file(File(image.path), height: 80, width: 80));
        });
      }
    }
    list.add(InkWell(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          alignment: Alignment.center,
          child: Icon(Icons.add, size: 40, color: Colors.grey),
        ),
        onTap: () async {
          image_picker.PickedFile image;
          try {
            image = await image_picker.ImagePicker().getImage(
                source: image_picker.ImageSource.gallery,
                maxHeight: 500,
                maxWidth: 500);
          } catch (ex) {
            print(ex);
          }
          if (image != null) {
            setState(() {
              widget.images.add(image);
            });
          }
        }));
    return new Wrap(children: list);
  }
}
