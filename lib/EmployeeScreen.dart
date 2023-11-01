// Страница сотрудников
import 'package:flutter/material.dart';

class EmployeeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Главная страница')),
      body: Center(
        child: Text('Привет, сотрудник!'),
      ),
    );
  }
}