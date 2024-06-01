import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_api/services/network.dart';

class PostImageView extends StatefulWidget {
   PostImageView({Key? key}) : super(key: key);


  @override
  State<PostImageView> createState() => _PostImageViewState();
}

class _PostImageViewState extends State<PostImageView> {

  Network network = Network();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
               network.getImageFromGallery().then((value) => setState(() {
                   
               }));
              },
              child: network.imageFile == null ?  const Text("Pick Image"):SizedBox(
                height: 500,
                width: 300,
                child: Image.file(File(
                    network.imageFile!.path
                ).absolute,fit: BoxFit.cover,),

              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: ()async{
                await network.uplaodImage();
               if(network.postImageStatusCode == 200){
                 print('SSSS ${network.postImageStatusCode}');
                 setState(() {
                   showDialog(context: context, builder: (context){
                     return const AlertDialog(
                       title: Text("Successful"),
                       content: Text("Image uploaded successfully"),
                     );
                   });
                 });
               }else{
                 setState(() {
                   showDialog(context: context, builder: (context){
                     return const AlertDialog(
                       title: Text("Unsuccessful"),
                       content: Text("Image is not uploaded"),
                     );
                   });
                 });
               }
              },
              // focusColor: Colors.white,
              // highlightColor: Colors.white,
              splashColor:Colors.red ,
              child: Ink(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.teal, borderRadius: BorderRadius.circular(40)),
                child: Center(
                    child: Text(
                      "Upload",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
