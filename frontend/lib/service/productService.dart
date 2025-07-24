

import 'dart:convert';
import 'dart:typed_data';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/service/storageHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';

class ProductService{

  //Adding product to database
  Future<Product?> addProduct(map, XFile? file) async {
    //getting the saved token from storage
    final token = await SecureStorageHelper.getToken();
    final uri = Uri.parse('$baseUrl/api/product');

    // Check if file exists
    if (file == null) {
      return null;
    }

    // Create multipart request
    var request = http.MultipartRequest('POST', uri);

    // Add JWT to Authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Add file part using XFile and setting the MediaType
    request.files.add(await http.MultipartFile.fromPath(
      'imageFile',
      file.path,
      contentType: http_parser.MediaType('image', 'jpeg')
    ));

    // Convert JSON to bytes for .fromBytes()
    final jsonString = jsonEncode(map);
    final jsonBytes = utf8.encode(jsonString);

    // Attach the JSON as a part with content-type application/json
    request.files.add(http.MultipartFile.fromBytes(
      'product',
      jsonBytes,
      contentType: http_parser.MediaType('application', 'json'),
      filename: 'product.json', // optional but sometimes required
    ));

    // Send request
    var response = await request.send();

    if (response.statusCode == 201) {
      final respStr=await response.stream.bytesToString();
      final decoded=jsonDecode(respStr);
      return Product.fromJson(decoded);
    } else {
      return null;
    }
  }

  //getting all products
  Future<List<Product>>? getProducts() async {
    final token = await SecureStorageHelper.getToken();
    Response response=await http.get(Uri.parse("$baseUrl/api/products"), headers: {
      'Authorization': 'Bearer $token'
    });
    Iterable result=jsonDecode(response.body);
    List<Product> list=List<Product>.from(result.map((model)=> Product.fromJson(model)));
    return list;
  }

  //Deleting a product
  Future deleteById(int? id) async {
    final token = await SecureStorageHelper.getToken();
    await http.delete(Uri.parse("$baseUrl/api/product/$id"), headers: {
      'Authorization': 'Bearer $token'
    });
  }

  //Fetching the image from server
  Future<Uint8List?> getImage(int? prodId) async {
    final token = await SecureStorageHelper.getToken();
    final response = await http.get(
        Uri.parse('$baseUrl/api/product/$prodId/image'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  //searching the product with the submitted value
  Future<List<Product>> searchProduct(String? value) async{
    final token = await SecureStorageHelper.getToken();
    final response = await http.get(
        Uri.parse('$baseUrl/api/products/search?keyword=$value'),
        headers: {'Authorization': 'Bearer $token'});
    Iterable result=jsonDecode(response.body);
    List<Product> list=List<Product>.from(result.map((model)=> Product.fromJson(model)));
    return list;

  }
}