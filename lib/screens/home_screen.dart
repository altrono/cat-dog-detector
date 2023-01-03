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
   bool _loading = false;
   late List _output;



   pickImage() async {
     var image = await picker.getImage(source: ImageSource.camera);
     
     if (image == null) return null;
     
     setState(() {
       _image = File(image.path);
     });
     classifyImage(_image);

   }

   pickGalleryImage() async {
     var image = await picker.getImage(source: ImageSource.gallery);

     if (image == null) return null;

     setState(() {
       _image = File(image.path);
     });

     classifyImage(_image);


   }

   classifyImage(File image) async {
     var output = await Tflite.runModelOnImage(
         path: image.path,
         numResults: 2,
         threshold: 0.5,
         imageMean: 127.5,
         imageStd: 127.5,);

     setState(() {
       _loading = false;
       _output = output!;
     });
   }

   loadModel() async {
     await Tflite.loadModel(
         model: 'assets/model_unquant.tflite',
         labels: 'assets/labels.txt',
     );
   }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {

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
              child: _loading  ?
                Container(
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
                ) :
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        child: Image.file(_image),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _output != null ?
                          Text(
                              '${_output[0]['label']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                          ):
                          Container(),
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


  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }


}
