import 'package:flutter/material.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nama", hintText: "Masukkan Nama"
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email", hintText: "Masukkan Email"
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Alamat", hintText: "Masukkan Alamat"
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "No Telepon", hintText: "Masukkan No Telepon"
                ),
              ),
            ),
          ],),
      ));
  }
}