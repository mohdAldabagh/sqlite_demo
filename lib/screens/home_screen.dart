import 'package:flutter/material.dart';
import 'package:sqlite_demo/screens/student_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adv. Mobile Course'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StudentScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('No Marks yet'),
      ),
    );
  }
}
