import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: EmployeeHomePage(),
    theme: ThemeData(
      primaryColor: Colors.orange,
    ),
  ));
}

class EmployeeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TechRepair'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Меню Сотрудника',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Существующие заявки',
                style: TextStyle(
                    color: Colors.orange,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExistingRequestsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/reo.jpg', // Путь к логотипу 
                width: 100, 
                height: 100, 
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  'Дорогой сотрудник добро пожаловать в компанию "TechRepair" - вашему надежному партнеру в сфере компьютерных услуг!', 
                  style: TextStyle( 
                    color: Colors.orange, 
                    fontSize: 18.0, 
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExistingRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Существующие заявки'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text('Здесь будут отображаться существующие заявки.'),
      ),
    );
  }
}
