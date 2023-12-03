import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage(ImageSource source) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    return image;
  } catch (e) {
    print('Error al seleccionar la imagen: $e');
    return null;
  }
}
