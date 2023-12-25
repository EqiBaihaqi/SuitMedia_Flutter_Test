import 'package:flutter/material.dart';
import 'package:suitmedia_test_flutter/pages/thirdscreen.dart';

class Screen2 extends StatefulWidget {
  Screen2({
    super.key,
    required this.name,
  });
  final String name;
  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String selectedUsername = 'Selected User Name';
  void updateUserName(String newName) {
    setState(() {
      selectedUsername = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Welcome'),
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Text(
                  selectedUsername,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Center(
                child: Container(
                  width: 300,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ThirdScreen(updateUserName)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2b637b),
                    ),
                    child: const Text(
                      'Choose a User',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
