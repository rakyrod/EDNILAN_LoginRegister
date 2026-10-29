
import 'package:flutter/material.dart';

void main() {
  runApp(const EdgeInsetsApp());
}

class EdgeInsetsApp extends StatelessWidget {
  const EdgeInsetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EdgeInsetsPage(),
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
          style: TextStyle(color: Colors.white),
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

              Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'EdgeInsets.all(30)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

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
                  ),
                ),
              ),

              const SizedBox(height: 30),

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
                    'EdgeInsets.only(left: 30, top: 10, right: 5, bottom: 20)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                  child: Text(
                    'EdgeInsets.fromLTRB(10, 20, 30, 40)',
                    style: TextStyle(color: Colors.white),
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
