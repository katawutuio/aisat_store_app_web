import 'dart:convert';
import 'dart:io';

import 'package:aisat_store_app_web/global_variable.dart';
import 'package:aisat_store_app_web/models/category.dart';
import 'package:aisat_store_app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dowuorys1", "aisat_app");

      // upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );

      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedBanner,
              identifier: 'pickedBanner', folder: 'categoryImages'));
      String banner = bannerResponse.secureUrl;

      CategoryModel category = CategoryModel(
        id: "", // id เป็น "" เพื่อให้ mongo generate id ให้
        name: name,
        image: image,
        banner: banner,
      );

      http.Response response = await http.post(Uri.parse("$uri/api/categories"),
          body: category.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded Category');
          });
    } catch (e) {
      print('Error uploading to cloudinary: $e');
    }
  }

  // fetch Category
  Future<List<CategoryModel>> loadCategories() async {
    try {
      // send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<CategoryModel> categories = data
            .map((categories) => CategoryModel.fromJson(categories))
            .toList();
        return categories;
      } else {
        // throw an exception
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error loading Categories $e');
    }
  }
}
