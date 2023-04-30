import 'package:flutter/material.dart';
import 'package:sqlite_demo/db_helper.dart';
import 'package:sqlite_demo/item_widget.dart';
import 'package:sqlite_demo/screens/student_screen.dart';
import 'package:sqlite_demo/student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper db = DatabaseHelper();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Adv. Mobile Course'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StudentScreen()),
            );
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Student>?>(
            future: db.getAllStudent(),
            builder: (context, AsyncSnapshot<List<Student>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ItemWidget(
                        student: snapshot.data![index],
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentScreen(
                                student: snapshot.data![index],
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        onLongPress: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure you want to delete this stduent?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      await db
                                          .deleteStudent(snapshot.data![index]);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  );
                }
                return const Center(
                  child: Text('No Stuents yet'),
                );
              }
              return const SizedBox.shrink();
            }));
  }
}
