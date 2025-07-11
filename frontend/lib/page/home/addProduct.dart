import 'dart:io';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/service/productService.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

//Creating a nickname for DropdownMenuEntry<String>
typedef MenuEntry = DropdownMenuEntry<String>;
List<String> brandMenu=["Xiomi","Oneplus","Apple","RealMe","Oppo"];
List<String> categoryMenu=["Electronics","Furniture","Kitchen","Groceries","Other"];

class _AddproductState extends State<Addproduct> {
  final _formKey=GlobalKey<FormState>();
  //creating entries for Dropdown
  static final List<MenuEntry> brandMenuEntries = UnmodifiableListView<MenuEntry>(
    brandMenu.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  static final List<MenuEntry> categoryMenuEntries = UnmodifiableListView<MenuEntry>(
    categoryMenu.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  String? dropDownBrandValue=brandMenu.first;
  String? dropDownCategoryValue=categoryMenu.first;
  bool? isAvailable= false;
  DateTime? selectedDate;
  String? prodName;
  String? desc;
  String? price;
  String? quantity;
  File? image;
  XFile? selectedImage;
  String? releaseDate;

  Future<void> _selectDate()async{
    DateTime? pickedDate=await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026));

    setState(() {
      //to be shown date in OutlinedButton
      releaseDate=pickedDate?.toIso8601String().substring(0,10);
      selectedDate=pickedDate;
    });
  }





  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05, horizontal: screenWidth*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Enter your product details",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Product Name"),
                validator: (val) => val!.isEmpty ? "Enter product name" : null,
                onChanged: (val) => setState(() => prodName=val),

              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Description"),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
                onChanged: (val) => setState(() => desc=val),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  DropdownMenu<String>(
                    initialSelection: brandMenu.first,
                    onSelected: (String? value)=> setState(() => dropDownBrandValue=value),
                    dropdownMenuEntries: brandMenuEntries,
                  ),
                  SizedBox(width: screenWidth*0.04,),
                  DropdownMenu<String>(
                    initialSelection: categoryMenu.first,
                    onSelected: (String? value)=> setState(() => dropDownCategoryValue=value),
                    dropdownMenuEntries: categoryMenuEntries,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: textInputDecoration.copyWith(hintText: "Price"),
                validator: (val) => val!.isEmpty ? "Enter price" : null,
                onChanged: (val) => setState(() => price=val),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: _selectDate,
                      child: Text(releaseDate ?? 'Release Date')),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        //Picking image from gallery
                        selectedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
                      },
                      child: Text("Select Image")
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: textInputDecoration.copyWith(hintText: "Stock quantity"),
                validator: (val) => val!.isEmpty ? "Enter quantity" : null,
                onChanged: (val) => setState(() => quantity=val),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Checkbox(
                    value: isAvailable,
                    onChanged: (value){
                      setState(() => isAvailable= value ?? false);
                    }
                  ),
                  // SizedBox(width: 10),
                  const Text("Product is available")
                ],
              ),
              SizedBox(height: screenHeight*0.07,),
              ElevatedButton(
                  onPressed: () async {
                    //converting DateTime to String for JsonEncoding
                    String? isoDate = selectedDate?.toIso8601String();
                    //sending Map and ImageFile
                    await ProductService().addProduct({
                      'name': prodName,
                      'description': desc,
                      'brand': dropDownBrandValue,
                      'price': price,
                      'category':dropDownCategoryValue,
                      'releaseDate': isoDate,
                      'productAvailable': isAvailable,
                      'stockQuantity':quantity,
                    }, selectedImage);
                  },
                  child: Text("Upload")
              )
            ],
          ),
        )),
    ) ;
  }
}
