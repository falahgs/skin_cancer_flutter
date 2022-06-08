import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String msg;
  String msg1;
  String msgfinal;
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker(); //allows us to pick image from gallery or camera
  String currentTtsString;
  double ttsSpeechRate1 = 0.5;
  double ttsSpeechRate2 = 1.0;
  double currentSpeechRate;
  bool bolSpeaking = false;
  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    //this function runs the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 7, //the amout of categories our neural network can predict
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;      
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
        model: 'assets/model_skin_cancer.tflite', labels: 'assets/labels.txt');
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
    print('hi');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(        
        elevation: 40.0,
        brightness: Brightness.dark,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 30.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'Upload Image Or Camera ',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 0.8),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        color: Colors.lightBlueAccent[100],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0x0FFC2CEA),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: _loading == true
                        ? null 
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  width: 250,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                ),
                                _output != null
                                    ? Text(
                                        ' The tumor is : ${_output[0]['label']}\n                   Prob.: ${(_output[0]['confidence'] * 100).toStringAsFixed(2) + '%'}',
                                        style: TextStyle(
                                            color: Colors.greenAccent[600],
                                            fontSize: 21,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Container(),
                                Divider(
                                  height: 15,
                                  thickness: 2,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[400],
                            borderRadius: BorderRadius.circular(15)),
                        child: FittedBox(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: pickGalleryImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[400],
                            borderRadius: BorderRadius.circular(15)),
                        child: FittedBox(
                          child: 
                              Icon(
                            Icons.photo_album,
                            size: 40,
                          ),
                        ),
                        
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}
