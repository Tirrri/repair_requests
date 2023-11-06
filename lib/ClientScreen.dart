// Страница клиентов
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

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
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[400],
              ),
              child: Text('Меню Клиента',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Заявка на ремонт',
                style: TextStyle(
                  color: Colors.green[400],
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
              leading: Icon(Icons.message),
              title: Text('Сотрудники',
                style: TextStyle(
                  color: Colors.green[400],
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
              Image.asset('assets/reo.jpg', // Путь к логотипу 
                width: 100, 
                height: 100, 
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text('Добро пожаловать в компанию "TechRepair" - вашему надежному партнеру в сфере компьютерных ремонтных услуг!', 
                  style: TextStyle( 
                    color: Colors.green[800], 
                    fontSize: 18.0, 
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

class RepairRequestPage extends StatefulWidget {
  @override
  _RepairRequestPageState createState() => _RepairRequestPageState();
}

class _RepairRequestPageState extends State<RepairRequestPage> {
  TextEditingController deviceTypeController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  DateTime? submissionDate;
  TextEditingController problemDescriptionController = TextEditingController();

  @override
  void dispose() {
    deviceTypeController.dispose();
    customerNumberController.dispose();
    problemDescriptionController.dispose();
    super.dispose();
  }

  Future<void> submitRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceType', deviceTypeController.text);
    await prefs.setString('customerNumber', customerNumberController.text);
    await prefs.setString('submissionDate', submissionDate.toString());
    await prefs.setString('problemDescription', problemDescriptionController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Заявка зарегистрирована'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != submissionDate) {
      setState(() {
        submissionDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка на ремонт'),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: deviceTypeController,
              decoration: InputDecoration(
                labelText: 'Тип устройства',
              ),
              textDirection: TextDirection.ltr,
            ),
            TextField(
              controller: customerNumberController,
              decoration: InputDecoration(
                labelText: 'Номер клиента',
              ),
              textDirection: TextDirection.ltr,
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: submissionDate != null
                        ? '${submissionDate!.day}.${submissionDate!.month}.${submissionDate!.year}'
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Дата подачи заявки',
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            TextField(
              controller: problemDescriptionController,
              decoration: InputDecoration(
                labelText: 'Описание проблемы',
              ),
              textDirection: TextDirection.ltr,
              maxLines: 5,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: submitRequest,
              child: Text('Подать заявку'),
            ),
          ],
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            EmployeeCard(
              name: 'Иван',
              surname: 'Иванов',
              patronymic: 'Иванович',
              experience: 5,
            ),
            EmployeeCard(
              name: 'Петр',
              surname: 'Петров',
              patronymic: 'Петрович',
              experience: 3,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final String name;
  final String surname;
  final String patronymic;
  final int experience;

  EmployeeCard({required this.name, required this.surname, required this.patronymic, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(
                '${name[0]}${surname[0]}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green[400],
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Имя: $name',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Фамилия: $surname',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text('Отчество: $patronymic',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text('Стаж работы: $experience лет',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
