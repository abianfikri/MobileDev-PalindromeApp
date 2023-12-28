import 'package:flutter/material.dart';
import 'package:palindrome_test/assets/style.dart';
import 'package:palindrome_test/controllers/api_service.dart';
import 'package:palindrome_test/view/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // Make Variable to set Username and palindrome
  String? username;
  String? palindrome;

  // create new variable extend Class ApiService to get method isPalindrome
  final controller = ApiService();

  // create variable Global Key
  final keyForm = GlobalKey<FormState>();

  // Function to show dialog
  Future<void> _showDialog(String message, String namePalindrome) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Palindrome Check'),
          content: Row(
            children: [
              Text('${namePalindrome} '),
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                green_blue_gradien,
                Colors.green.shade200,
                green_blue_gradien,
              ],
            ),
          ),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(71, 248, 246, 246),
                  radius: 55,
                  child: Icon(
                    Icons.person_add_alt_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                // Name
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Sesuaikan nilai radius sesuai kebutuhan
                  ),
                  width: 320,
                  height: 52,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      username = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Palindrome
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Sesuaikan nilai radius sesuai kebutuhan
                  ),
                  width: 320,
                  height: 52,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Palindrome",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      palindrome = value;
                    },
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                // Button Check
                InkWell(
                  onTap: () {
                    bool isPalindrome =
                        controller.isPalindrome(palindrome.toString());
                    String message = isPalindrome
                        ? 'is a palindrome.'
                        : 'is not a palindrome.';
                    _showDialog(message, palindrome.toString());
                  },
                  child: Container(
                    width: 320,
                    height: 41,
                    decoration: BoxDecoration(
                      color: green_blue_gradien,
                      borderRadius: BorderRadius.circular(
                          12.0), // Sesuaikan nilai radius sesuai kebutuhan
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CHECK",
                          style: TextStyle(
                            color: white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Button Next
                InkWell(
                  onTap: () {
                    try {
                      if (keyForm.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SecondScreen(getUsername: username!),
                          ),
                        ).then((value) {
                          setState(() {
                            username ?? "";
                          });
                        });
                      }
                    } catch (e) {
                      throw e.toString();
                    }
                  },
                  child: Container(
                    width: 320,
                    height: 41,
                    decoration: BoxDecoration(
                      color: green_blue_gradien,
                      borderRadius: BorderRadius.circular(
                          12.0), // Sesuaikan nilai radius sesuai kebutuhan
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NEXT",
                          style: TextStyle(
                            color: white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
