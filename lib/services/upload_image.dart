import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> uploadImage(File image) async {
  try {
    final String namefile = image.path.split("/").last;
    final Reference ref = storage.ref().child("images").child(namefile);
    final UploadTask uploadTask = ref.putFile(image);

    await uploadTask.whenComplete(() => true);

    return true;
  } catch (e) {
    print('Error al subir la imagen: $e');
    return false;
  }
}
