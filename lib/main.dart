import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Ваше приложение',
    initialRoute: '/login',
    routes: {
      '/login': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
    },
  ));
}

List<Map<String, dynamic>> clients = [
  {'username': 'Teri', 'password': '741'},
  {'username': 'Riw', 'password': '852'},
  {'username': 'Hiop', 'password': '963'},
];

List<Map<String, dynamic>> employees = [
  {'username': 'Geri', 'password': '789', 'employeeCode': '1234'},
  {'username': 'Ivan', 'password': '456', 'employeeCode': '5678'},
  {'username': 'Kervo', 'password': '123', 'employeeCode': '9012'},
];

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  bool isEmployee = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход')),
      body: Container(
        color: Colors.green, // Устанавливаем зеленый цвет фона
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Логин'),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Пароль'),
                    obscureText: true,
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEmployee = true;
                            });
                          },
                          child: Text('Сотрудник'),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEmployee = false;
                            });
                          },
                          child: Text('Клиент'),
                        ),
                      ),
                    ],
                  ),
                  if (isEmployee == true) ...[
                    SizedBox(height: 12.0),
                    TextField(
                      controller: employeeCodeController,
                      decoration: InputDecoration(labelText: 'Код сотрудника'),
                    ),
                  ],
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      String employeeCode = employeeCodeController.text;

                      bool isLoginValid = false;
                      bool isPasswordValid = false;
                      bool isEmployeeCodeValid = false;

                      for (var client in clients) {
                        if (username == client['username'] && password == client['password']) {
                          isLoginValid = true;
                          isPasswordValid =true;
                          break;
                        }
                      }

                      for (var employee in employees) {
                        if (username == employee['username'] && password == employee['password']) {
                          isLoginValid = true;
                          isPasswordValid = true;

                          if (isEmployee && employeeCode == employee['employeeCode']) {
                            isEmployeeCodeValid = true;
                          }
                          break;
                        }
                      }

                      if (isLoginValid && isPasswordValid) {
                        if (isEmployee && !isEmployeeCodeValid) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Ошибка входа'),
                                content: Text('Неправильный код сотрудника.'),
                                actions: [
                                  TextButton(
                                    child: Text('ОК'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.pushNamed(context, '/home');
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Ошибка входа'),
                              content: Text('Неправильный логин или пароль.'),
                              actions: [
                                TextButton(
                                  child: Text('ОК'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Войти'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главная')),
      body: Center(
        child: Text('Добро пожаловать на главную страницу!'),
      ),
    );
  }
}