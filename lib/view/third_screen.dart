import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palindrome_test/controllers/api_service.dart';
import 'package:palindrome_test/model/user_data_model.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<UserData> userList = [];
  final controller = ApiService();

  // Fungsi untuk mengambil data dari API
  Future<void> fetchData2() async {
    try {
      final userDataList = await controller.fetchData();

      // Set state untuk memperbarui tampilan dengan data terbaru
      setState(() {
        userList = userDataList.data;
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData2(); // Panggil fetchData2 pada saat inisialisasi tampilan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Third Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue.shade700,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.0),
          child: Divider(
            color: Colors.black,
            thickness: .2,
          ),
        ),
      ),
      body: userList.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: .5,
                  color: Colors.grey,
                ),
              ),
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipOval(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userList[index].avatar),
                    ),
                  ),
                  title: Text(
                      "${userList[index].firstName} ${userList[index].lastName}"),
                  subtitle: Text(userList[index].email),
                  onTap: () {
                    // Kembalikan nama user yang dipilih ke halaman sebelumnya
                    Navigator.pop(context, userList[index]);
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
