import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? photo;
  final ImagePicker picker= ImagePicker();

  get fit => null;

  //bottom sheet dialing
  showBottomSheetDialog(context){
    showModalBottomSheet(context: context,
        builder:(BuildContext bc)
        {
          return SafeArea(child: Wrap(children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: (){
                //call a function for gallery
                imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: (){
                //call a function for camera
                imgFromCamera();
                Navigator.of(context).pop();//FOR REMOVE BOOTOM SHEET DIALOG
              },
            ),
          ],));

        });
  }
//for taking image form gallery

  Future imgFromGallery() async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,
  maxHeight: 1200,
  maxWidth: 1200,
  imageQuality: 100);

    setState((){
      if(pickedFile!=null){
        photo=File(pickedFile.path);
      }
      else
      {
        print("No image selected");
      }
    }
    );
}



//for taking image form Camera

  Future imgFromCamera() async{
    final pickedFile=await picker.pickImage(source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);

    setState((){
      if(pickedFile!=null){
        photo=File(pickedFile.path);
      }
      else
      {
        print("No image selected");
      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF88379),
        title: Text("Camera App Example",style: TextStyle(
          color: Colors.black
        ),),
      ),

      body: Column(
        children: [
          photo != null ?Image.file(photo!,
            width:MediaQuery.sizeOf(context).width ,
            height:MediaQuery.sizeOf(context).height/2 ,
            fit:BoxFit.fitWidth,):
          Image.asset("assets/images/img.png",
            width:MediaQuery.sizeOf(context).width ,
           height:MediaQuery.sizeOf(context).height/2 ,
                fit:BoxFit.fitWidth,),


          SizedBox(height: 20,),
          
          ElevatedButton(
              style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF88379),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: (){
                showBottomSheetDialog(context);




              }, child: Text("Pick Image",style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold
          ),))


        ],
      ),
    );
  }
}
