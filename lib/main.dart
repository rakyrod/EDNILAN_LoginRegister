
import 'package:flutter/material.dart';

void main() {
  runApp(const EdgeInsetsApp());
}

class EdgeInsetsApp extends StatelessWidget {
  const EdgeInsetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 4 - EdgeInsets',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const EdgeInsetsPage(),
    );
  }
}

class EdgeInsetsPage extends StatelessWidget {
  const EdgeInsetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDNILAN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFFFF7FF),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // 1. EdgeInsets.all()
              Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'EdgeInsets.all(30)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 2. EdgeInsets.symmetric()
              Container(
                width: double.infinity,
                color: Colors.yellow,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: Text(
                    'EdgeInsets.symmetric(horizontal: 40, vertical: 10)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 3. EdgeInsets.only()
              Container(
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 10,
                    right: 5,
                    bottom: 20,
                  ),
                  child: Text(
                    'EdgeInsets.only(left: 30, top: 10, '
                    'right: 5, bottom: 20)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 4. EdgeInsets.fromLTRB()
              Container(
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(
                    10,
                    20,
                    30,
                    40,
                  ),
                  child: Text(
                    'EdgeInsets.fromLTRB(10, 20, 30, 40)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
