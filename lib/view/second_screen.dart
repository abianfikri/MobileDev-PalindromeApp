import 'package:flutter/material.dart';
import 'package:palindrome_test/assets/style.dart';

import 'package:palindrome_test/controllers/api_service.dart';
import 'package:palindrome_test/model/user_data_model.dart';
import 'package:palindrome_test/view/third_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.getUsername,
  }) : super(key: key);
  final String getUsername;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = ApiService();
  UserData? selectedUser;
  String? tempUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Second Screen",
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
          preferredSize: Size.fromHeight(7.0),
          child: Divider(
            color: Colors.black,
            thickness: .2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome"),
                    Text(
                      selectedUser != null
                          ? "${selectedUser!.firstName} ${selectedUser!.lastName}"
                          : tempUsername ?? widget.getUsername,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                child: selectedUser != null
                    ? Text(
                        "${selectedUser!.firstName} ${selectedUser!.lastName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "Selected User Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    // Navigator.push returns a result from the third screen
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdScreen(),
                      ),
                    );

                    if (result != null && result is UserData) {
                      setState(() {
                        tempUsername = widget.getUsername;
                        selectedUser = result;
                      });
                    }

                    // Update the selected user if a user was selected in the third screen
                    if (result != null && result is UserData) {
                      setState(() {
                        selectedUser = result;
                      });
                    }
                  },
                  child: Container(
                    width: 320,
                    height: 41,
                    decoration: BoxDecoration(
                        color: green_blue_gradien,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose a User",
                          style: TextStyle(
                            color: white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
