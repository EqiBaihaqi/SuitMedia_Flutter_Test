import 'package:flutter/material.dart';
import 'pages/secondscreen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final TextEditingController _palindromeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _showDialogTrue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Is it Palindrome?'),
          content: const Text('It is Palindrome!!!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close Dialog'),
            )
          ],
        );
      },
    );
  }

  Future<void> _showDialogFalse(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Is it Palindrome?'),
          content: const Text('It is not Palindrome..'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close Dialog'),
            )
          ],
        );
      },
    );
  }

  bool isPalindrome(String text) {
    String cleanText =
        text.replaceAll(RegExp(r'\s|[^a-zA-Z0-9]'), '').toLowerCase();
    return cleanText == cleanText.split('').reversed.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/background1.png'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFF97C4CE),
                radius: 60,
                child: Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    label: const Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: _palindromeController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    label: const Text(
                      'Palindrome',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: () {
                    String enteredText =
                        _palindromeController.text.toLowerCase();
                    print('Entered text = $enteredText');
                    if (isPalindrome(enteredText)) {
                      _showDialogTrue(context);
                    } else {
                      _showDialogFalse(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2b637b),
                  ),
                  child: const Text(
                    'Check',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen2(
                                  name: _nameController.text,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2b637b),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
