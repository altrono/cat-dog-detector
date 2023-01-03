import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final picker = ImagePicker();
  late File _image;

   pickImage() async {
     var image = await picker.getImage(source: ImageSource.camera);
     
     if (image == null) return null;
     
     setState(() {
       _image = File(image.path);
     });

   }

   pickGalleryImage() async {
     var image = await picker.getImage(source: ImageSource.gallery);

     if (image == null) return null;

     setState(() {
       _image = File(image.path);
     });


   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text('Teachablemachine CNN', style: TextStyle(
              color: Color(0xFFEEDA28),
              fontSize: 15
            ),),
            const SizedBox(height: 6,),
            const Text(
                'Detect Dogs and Cats',
                style: TextStyle(
                  color: Color(0xFFE99600),
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 300,
                child: Column(
                  children: [
                    Image.asset('assets/cat.png'),
                    SizedBox(height: 50,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 260,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                              decoration: BoxDecoration(
                                color: Color(0xFFE99600),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('Take a photo', style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          SizedBox(width: 30,),
                          GestureDetector(
                            onTap: pickGalleryImage,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 260,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                              decoration: BoxDecoration(
                                color: Color(0xFFE99600),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('Camera Roll', style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
