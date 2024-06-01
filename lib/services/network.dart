
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:post_api/services/app_url.dart';
class Network{
  int? registeredStatusCode;
  int? postImageStatusCode;
  Future<int> registerUser(String email, String password)async{
  try{
    http.Response response  = await http.post(Uri.parse("$registeredApiBaseURL$registeredApiEndPoint"),
        body: {
          'email' : email,
          'password': password,
        }
    );
    if(response.statusCode == 200){
      print("User Registered Successfully");
      registeredStatusCode = response.statusCode;
    }else{
      print("User not Registered");

      registeredStatusCode = response.statusCode;
    }
  }catch(e){print(e.toString());
  }
  return registeredStatusCode!;
  }

  File? imageFile;
  ImagePicker imagePicker = ImagePicker();

  Future<void> getImageFromGallery()async{
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile =  File(pickedImage!.path);

  }

  //UPLOAD IMAGE

  Future<void> uplaodImage()async{
    var stream = http.ByteStream(imageFile!.openRead());
    stream.cast();

    var length = await imageFile!.length();
    var uri =  Uri.parse('$postImageApiBaseURL$postImageApiEndPoint');

    var request =  http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title" ;

    var multipart = http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multipart);

    var response = await request.send() ;

    if(response.statusCode == 200){
      print('image uploaded');
      print(response.statusCode);
      postImageStatusCode = response.statusCode;

    }else {
      print('failed');
      postImageStatusCode = response.statusCode;
    }
  }
}