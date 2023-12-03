import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotin/services/select_image.dart';
import 'package:fotin/services/upload_image.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imagen_to_upload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gestion de imagenes'),
        ),
        body: Column(
          children: [
            imagen_to_upload != null
                ? Image.file(imagen_to_upload!)
                : Container(
                    margin: const EdgeInsets.all(10),
                    height: 200,
                    width: double.infinity,
                    color: Colors.red,
                  ),
            ElevatedButton(
              onPressed: () async {
                final imagen = await getImage(ImageSource.gallery);
                if (imagen != null) {
                  setState(() {
                    imagen_to_upload = File(imagen.path);
                  });
                }
              },
              child: const Text("Seleccionar imagen desde galería"),
            ),
            ElevatedButton(
              onPressed: () async {
                final imagen = await getImage(ImageSource.camera);
                if (imagen != null) {
                  setState(() {
                    imagen_to_upload = File(imagen.path);
                  });
                }
              },
              child: const Text("Tomar foto"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (imagen_to_upload == null) {
                  return;
                }

                final uploaded = await uploadImage(imagen_to_upload!);
                if (uploaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Imagen subida")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al subir imagen")),
                  );
                }
              },
              child: const Text("Subir a Firebase"),
            ),
          ],
        ));
  }
}
