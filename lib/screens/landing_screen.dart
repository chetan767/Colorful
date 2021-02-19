import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:color_blind/components/rounded_icon_button.dart';
import 'package:color_blind/components/bottom_button.dart';
import 'dart:io';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'color_screen.dart';
import 'package:image_native_resizer/image_native_resizer.dart';
import 'dart:io';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  File image;
  var pic;
  double width;
  double height;
  void getImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
     pic = await imagePicker.getImage(source: imageSource);
    final localImagePath = await pic.path;
    File imageTemp = File(pic.path);
    var decodedImage = await decodeImageFromList(imageTemp.readAsBytesSync());

    width = decodedImage.width/8;
    height = decodedImage.height/8;
    final resizedPath = await ImageNativeResizer.resize(
      imagePath: localImagePath,
      maxWidth: width ,
      maxHeight: height,
      quality : 100
    );

    setState(() {
      image = File(resizedPath);
      print(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: GradientCard(
                gradient: Gradients.rainbowBlue,
                shadowColor: Gradients.tameer.colors.last.withOpacity(0.25),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Let's see all the colors",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                ),
              ),
            ),

            Container(
              height: 400,
              child: image != null
                  ? Image.file(image)
                  : Center(child: Text('No image selected')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundIconButton(
                    icon: Icons.camera_enhance,
                    onPressed: () {
                      getImage(ImageSource.camera);
                    }),
                RoundIconButton(
                    icon: Icons.add_photo_alternate,
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: BottomButton(onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorScreen(pic: image,width: width,height: height,)),
                );
              }

                  , buttonTitle: "See Colors"),
            ),

          ],
        ),

      );
  }
}
