import 'package:aisat_store_app_web/global_variable.dart';
import 'package:aisat_store_app_web/models/subcategory.dart';
import 'package:aisat_store_app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubCategory(
      {required String categoryId,
      required String categoryName,
      required dynamic pickedImage,
      required String subCategoryName,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dowuorys1", "aisat_app");

      // upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );

      String image = imageResponse.secureUrl;

      Subcategory subcategory = Subcategory(
          id: "",
          categoryId: categoryId,
          categoryName: categoryName,
          image: image,
          subCategoryName: subCategoryName);

      http.Response response = await http.post(
          Uri.parse("$uri/api/subcategories"),
          body: subcategory.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Subcategory Uploaded');
          });
    } catch (e) {
      print("Error $e");
    }
  }
}
