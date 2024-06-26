import 'package:flutter/material.dart';
import 'package:project3_kontakform/controller/kontak_controller.dart';
import 'package:project3_kontakform/model/kontak.dart';
import 'package:project3_kontakform/widget/kontak_form.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KontakController _controller = KontakController();

  @override
  void initState() {
    super.initState();
    _controller.getPeople();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kontak"),
      ),
      body: FutureBuilder<List<Kontak>>(
        future: _controller.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Eror: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kontak kontak = snapshot.data![index];
                return ListTile(
                  title: Text(kontak.nama),
                  subtitle: Text(kontak.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kontak.foto),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormKontak())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
