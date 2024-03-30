import 'dart:ffi';
import 'dart:io';

import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<String> fooditems = ['Outdoor', 'Indoor', 'office', 'Garden'];
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getimage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null &&
        namecontroller.text != "" &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": namecontroller.text,
        "Price": pricecontroller.text,
        "Detail": detailcontroller.text
      };
      await DatabaseMothed().addFoodItem(addItem, value!).then(((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: txtcolor,
          content: Text(
            'Food added successfuly!!',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Admin Home',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 25.0),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50, right: 0),
            child: Text(
              'Add a plant image',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: selectedImage == null
                ? GestureDetector(
                    onTap: () {
                      getimage();
                    },
                    child: Card(
                      elevation: 6,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: fillfield,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  )
                : Card(
                    elevation: 6,
                    child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: fillfield,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, right: 200),
            child: Text(
              'Plant Name',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: fillfield,
                    hintText: 'Enter a plant name',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins', fontSize: 12.0, color: txtcolor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))))),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, right: 210),
            child: Text(
              'Plant Price',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: TextField(
                controller: pricecontroller,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: fillfield,
                    hintText: 'Enter a plant price',
                    hintStyle: TextStyle(
                        height: 0.2,
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: txtcolor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    )))),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 30,
              right: 200,
            ),
            child: Text(
              'Plant Detail',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: TextField(
                controller: detailcontroller,
                maxLines: 6,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: fillfield,
                    hintText: 'Enter a plant detail',
                    hintStyle: TextStyle(
                        height: 0.2,
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: txtcolor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    )))),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 30,
              right: 160,
            ),
            child: Text(
              'Select Category',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
                color: fillfield,
              ),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    items: fooditems
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Select Category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                    ),
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: black,
                    ),
                    value: value,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              // LoginAdmin();
              uploadItem();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                "Add",
                style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    ));
  }
}
