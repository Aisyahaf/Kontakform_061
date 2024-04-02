import 'dart:convert';
import 'dart:io';

import 'package:project3_kontakform/model/kontak.dart';
import 'package:project3_kontakform/service/kontak_service.dart';

class KontakController {
  final KontakService _service = KontakService();

  Future<Map<String,dynamic>> addPerson(Kontak kontak, File? file)async{
    Map<String, String> data = {
      'nama' : kontak.nama,
      'email' : kontak.email,
      'alamat' : kontak.alamat,
      'telepon' : kontak.telepon,
      // 'foto' : kontak.foto
    };
    
    try{
    var response = await _service.addPerson(data, file);

    if(response.statusCode == 200){
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
      List<dynamic> peopleData = await _service.fetchPeople();
      List<Kontak> people = 
            peopleData.map((json) => Kontak.fromMap(json)).toList();
      return people;
    }catch(e){
      // ignore: avoid_print
      print(e);
      throw Exception('Failed to get people');
    }
  }
}
