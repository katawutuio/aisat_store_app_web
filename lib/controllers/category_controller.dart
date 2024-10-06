import 'package:cloudinary_public/cloudinary_public.dart';

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage, required dynamic pickedBanner}) async {
    try {
      final cloudinary = CloudinaryPublic("dowuorys1", "aisat_app");

      // upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );
      print(imageResponse);

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedBanner,
              identifier: 'pickedBanner', folder: 'categoryImages'));
      print(bannerResponse);
    } catch (e) {
      print('Error uploading to cloudinary: $e');
    }
  }
}
