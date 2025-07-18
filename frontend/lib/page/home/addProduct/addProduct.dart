import 'dart:ffi';
import 'dart:io';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/service/productService.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/product.dart';

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
  //defining the style of buttons inside menu by style property using constant
  static final List<MenuEntry> brandMenuEntries = UnmodifiableListView<MenuEntry>(
    brandMenu.map<MenuEntry>((String name) => MenuEntry(value: name, label: name, style: buttonStyle)),
  );
  static final List<MenuEntry> categoryMenuEntries = UnmodifiableListView<MenuEntry>(
    categoryMenu.map<MenuEntry>((String name) => MenuEntry(value: name, label: name, style:  buttonStyle)),
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

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      dropDownBrandValue = brandMenu.first;
      dropDownCategoryValue = categoryMenu.first;
      isAvailable= false;
      selectedDate=null;
      prodName=null;
      desc=null;
      price=null;
      quantity=null;
      image=null;
      selectedImage=null;
      releaseDate=null;
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
                decoration: const InputDecoration(
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
                ),
                validator: (val) => val!.isEmpty ? "Enter product name" : null,
                onChanged: (val) => setState(() => prodName=val),
                style: Theme.of(context).textTheme.titleSmall
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
                ),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
                onChanged: (val) => setState(() => desc=val),
                style: Theme.of(context).textTheme.titleSmall
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  DropdownMenu<String>(
                    initialSelection: brandMenu.first,
                    onSelected: (String? value)=> setState(() => dropDownBrandValue=value),
                    dropdownMenuEntries: brandMenuEntries,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.white)
                    ),
                    inputDecorationTheme: textInputDecoration,
                    textStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(width: screenWidth*0.04,),
                  DropdownMenu<String>(
                    initialSelection: categoryMenu.first,
                    onSelected: (String? value)=> setState(() => dropDownCategoryValue=value),
                    dropdownMenuEntries: categoryMenuEntries,
                    menuStyle: const MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)
                    ),
                    inputDecorationTheme: textInputDecoration,
                    textStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
                ),
                validator: (val) => val!.isEmpty ? "Enter price" : null,
                onChanged: (val) => setState(() => price=val),
                style: Theme.of(context).textTheme.titleSmall
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: Text(releaseDate ?? 'Release Date'),
                  ),
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
                decoration: const InputDecoration(
                  hintText: "Stock Quantity",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  )
                ),
                validator: (val) => val!.isEmpty ? "Enter quantity" : null,
                onChanged: (val) => setState(() => quantity=val),
                style: Theme.of(context).textTheme.titleSmall
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
                  const Text(
                    "Product is available",
                    style: TextStyle(
                      color: Colors.white
                    )
                  )
                ],
              ),
              SizedBox(height: screenHeight*0.07,),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      //converting DateTime to String for JsonEncoding
                      String? isoDate = selectedDate?.toIso8601String();
                      //sending Map and ImageFile
                      Product? product=await ProductService().addProduct({
                        'name': prodName,
                        'description': desc,
                        'brand': dropDownBrandValue,
                        'price': price,
                        'category':dropDownCategoryValue,
                        'releaseDate': isoDate,
                        'productAvailable': isAvailable,
                        'stockQuantity':quantity,
                      }, selectedImage);
                      if(product != null){
                        const snackbar=SnackBar(content: Text("Product has been added successfully"));
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        _resetForm();
                      }
                      else{
                        const snackbar=SnackBar(content: Text("Product has not been added"));
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  },
                  child: Text("Upload")
              )
            ],
          ),
        )),
    ) ;
  }
}
