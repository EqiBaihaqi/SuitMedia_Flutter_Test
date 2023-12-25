import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:suitmedia_test_flutter/model/user.dart';

class ThirdScreen extends StatefulWidget {
  final Function(String) updateUserName;

  ThirdScreen(this.updateUserName);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int page = 1;
  bool isLoading = false;

  Future<void> _fetchUsers() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> usersData = data['data'];

      setState(() {
        users.addAll(usersData.map((user) {
          return User(
            email: user['email'],
            firstName: user['first_name'],
            lastName: user['last_name'],
            avatar: user['avatar'],
          );
        }).toList());
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _refresh() async {
    users.clear();
    page = 1;
    await _fetchUsers();
  }

  Future<void> _loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        page++;
      });

      await _fetchUsers();

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            if (index == users.length) {
              return _buildLoadingIndicator();
            } else {
              return ListTile(
                leading: Image.network(users[index].avatar),
                title:
                    Text('${users[index].firstName} ${users[index].lastName}'),
                subtitle: Text(users[index].email),
                onTap: () {
                  // Update the selected user's name in the SecondScreen
                  widget.updateUserName(
                      '${users[index].firstName} ${users[index].lastName}');

                  Navigator.pop(context);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
