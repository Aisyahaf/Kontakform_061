import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3_kontakform/controller/kontak_controller.dart';
import 'package:project3_kontakform/model/kontak.dart';
import 'package:project3_kontakform/screen/home_view.dart';
import 'package:project3_kontakform/screen/map_screen.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final kontakController = KontakController();
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _noteleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print("No Image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Kontak")),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nama", hintText: "Masukkan Nama"),
                    controller: _namaController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Masukkan Email"),
                    controller: _emailController,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Alamat"),
                      _alamat == null
                          ? const SizedBox(
                              width: double.infinity,
                              child: Text('Alamat kosong'))
                          : Text('$_alamat'),
                      _alamat == null
                          ? TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
                                      setState(() {
                                        _alamat = selectedAddress;
                                      });
                                    }),
                                  ),
                                );
                              },
                              child: const Text('Pilih Alamat'),
                            )
                          : TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
                                      setState(() {
                                        _alamat = selectedAddress;
                                      });
                                    }),
                                  ),
                                );
                                setState(() {});
                              },
                              child: const Text('Ubah Alamat'),
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "No Telepon",
                        hintText: "Masukkan No Telepon"),
                    controller: _noteleponController,
                  ),
                ),
                _image == null
                    ? const Text("Tidak ada gambar yang dipilih")
                    : Image.file(_image!),
                ElevatedButton(
                  onPressed: getImage,
                  child: const Text("Pilih Gambar"),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          var result = await kontakController.addPerson(
                              Kontak(
                                  nama: _namaController.text,
                                  email: _emailController.text,
                                  alamat: _alamat ?? '',
                                  telepon: _noteleponController.text,
                                  foto: _image!.path),
                              _image);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'])),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()),
                              (route) => false);
                        }
                      },
                      child: const Text("Submit")),
                )
              ],
            ),
          )),
    );
  }
}
