import 'dart:convert';

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
              title: Text(
                'Существующие заявки',
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
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Выход',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
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

class ExistingRequestsPage extends StatefulWidget {
  @override
  _ExistingRequestsPageState createState() => _ExistingRequestsPageState();
}

class _ExistingRequestsPageState extends State<ExistingRequestsPage> {
  List<RepairRequest> repairRequests = [];
  List<RepairRequest> filteredRequests = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? requestList = prefs.getStringList('repairRequests');
    if (requestList != null) {
      setState(() {
        repairRequests = requestList
            .map((requestData) =>
                RepairRequest.fromJson(jsonDecode(requestData)))
            .toList();
        filteredRequests = repairRequests;
      });
    }
  }

  Future<void> sortAllRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? requestList = prefs.getStringList('repairRequests');
    if (requestList != null) {
      List<RepairRequest> sortedRequests = requestList
          .map((requestData) =>
              RepairRequest.fromJson(jsonDecode(requestData)))
          .toList();
      sortedRequests.sort((a, b) =>
          a.submissionDate.compareTo(b.submissionDate));

      setState(() {
        repairRequests = sortedRequests;
        filteredRequests = repairRequests;
      });
    }
  }

  Future<void> sortNewRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? requestList = prefs.getStringList('repairRequests');

    if (requestList != null) {
      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime endOfToday =
          DateTime(now.year, now.month, now.day, 23, 59, 59);
      List<RepairRequest> sortedRequests = requestList
          .map((requestData) =>
              RepairRequest.fromJson(jsonDecode(requestData)))
          .where((request) =>
              request.submissionDate.isAfter(startOfToday) &&
              request.submissionDate.isBefore(endOfToday))
          .toList();

      sortedRequests.sort((a, b) =>
          b.submissionDate.compareTo(a.submissionDate));
      setState(() {
        repairRequests = sortedRequests;
        filteredRequests = repairRequests;
        print(repairRequests);
      });
    }
  }

  Future<void> deleteRequest(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? requestList = prefs.getStringList('repairRequests');
    if (requestList != null) {
      setState(() {
        repairRequests.removeAt(index);
        filteredRequests.removeAt(index);
        requestList = repairRequests
            .map((request) => jsonEncode(request.toJson()))
            .toList();
        prefs.setStringList('repairRequests', requestList!);
      });
    }
  }

Future<void> searchRequest(String query) async {
  List<RepairRequest> searchResults = repairRequests
      .where((request) =>
          request.deviceType.toLowerCase().contains(query.toLowerCase()))
      .toList();

  setState(() {
    filteredRequests = searchResults;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                onChanged: (value) => searchRequest(value),
                decoration: InputDecoration(
                  hintText: 'Поиск заявок...',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              )
            : Text('Существующие заявки'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  filteredRequests = repairRequests;
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.all_inclusive),
            onPressed: sortAllRequests,
          ),
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: sortNewRequests,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredRequests.length,
        itemBuilder: (context, index) {
          RepairRequest request = filteredRequests[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                deleteRequest(index);
              }
            },
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(request.deviceType),
                subtitle: Text(request.customerNumber),
                trailing: Text(
                    '${request.submissionDate.day}.${request.submissionDate.month}.${request.submissionDate.year}'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Детали заявки'),
                        content:
                            Text('Описание проблемы: ${request.problemDescription}'),
                        actions: [
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
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
 
class RepairRequest {
  String deviceType;
  String customerNumber;
  DateTime submissionDate;
  String problemDescription;
  RepairRequest({
    required this.deviceType,
    required this.customerNumber,
    required this.submissionDate,
    required this.problemDescription,
  });

  factory RepairRequest.fromJson(Map<String, dynamic> json) {
    return RepairRequest(
      deviceType: json['deviceType'],
      customerNumber: json['customerNumber'],
      submissionDate: DateTime.parse(json['submissionDate']),
      problemDescription: json['problemDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceType': deviceType,
      'customerNumber': customerNumber,
      'submissionDate': submissionDate.toString(),
      'problemDescription': problemDescription,
    };
  }
}