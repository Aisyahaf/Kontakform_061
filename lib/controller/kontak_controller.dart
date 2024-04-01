import 'dart:convert';
import 'dart:io';

import 'package:project3_kontakform/model/kontak.dart';
import 'package:project3_kontakform/service/kontak_service.dart';

class KontakController {
  final kontakService = KontakService();

  Future<Map<String,dynamic>> addPerson(Kontak person, File? file)async{
    Map<String, String> data = {
      'nama' : person.nama,
      'email' : person.email,
      'alamat' : person.alamat,
      'telepon' : person.telepon,
    };
    
    try{
    var response = await kontakService.addPerson(data, file);

    if(response.statusCode == 201){
        return{
          'success' : true,
          'message' : 'Data berhasil disimpan',
        };
      }else{
        if(response.headers['content-type']!.contains('application/json')){
          var decodedJson = jsonDecode(response.body);
          return{
            'success' : false,
            'message' : decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return{
          'success' : false,
          'message' : decodedJson['message'] ?? 'Terjadi Kesalahan saat menyimpan data',
        };
      }
    }catch(e){
      return{
        'success' : false,
        'message' : 'Terjadi kesalahan: $e'
      };
    }
  }

  Future<List<Kontak>> getPeople() async{
    try{
      List<dynamic> peopleData = await kontakService.fetchPeople();
      List<Kontak> people = peopleData.map((json) => Kontak.fromMap(json)).toList();
      return people;
    }catch(e){
      print(e);
      throw Exception('Failed to get people');
    }
  }
}