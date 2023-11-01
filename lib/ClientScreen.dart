import 'package:flutter/material.dart';

class ClientHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('TechRepair'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.green[400],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Заявка на ремонт',
                style: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepairRequestPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Сотрудники',
                style: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeesPage()),
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
                  'Добро пожаловать в компанию "TechRepair" - вашему надежному партнеру в сфере компьютерных ремонтных услуг!', 
                  style: TextStyle( 
                    color: Colors.green[800], 
                    fontSize: 18.0, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class RepairRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка на ремонт'),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: Text(
          'Страница заявки на ремонт',
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }
}

class EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: Text(
          'Страница сотрудников',
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }
}
