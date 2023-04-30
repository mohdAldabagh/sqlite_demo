import 'package:flutter/material.dart';
import 'package:sqlite_demo/db_helper.dart';
import 'package:sqlite_demo/student.dart';

class StudentScreen extends StatelessWidget {
  final Student? student;
  const StudentScreen({super.key, this.student});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper db = DatabaseHelper();
    final nameController = TextEditingController();
    final markController = TextEditingController();

    if (student != null) {
      nameController.text = student!.name;
      markController.text = student!.mark;
    }

    return Scaffold(
      appBar:
          AppBar(title: Text(student == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'Add Student\'s Mark ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                controller: nameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    hintText: 'Enter Student\'s Name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Colors.white, width: 0.75))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                controller: markController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Enter Student\'s Mark',
                    labelText: 'Mark',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white, width: 0.75),
                    )),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        side: BorderSide(color: Colors.white, width: 0.75),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final name = nameController.value.text;
                    final mark = markController.value.text;

                    if (name.isEmpty || mark.isEmpty) {
                      return;
                    }

                    final Student std =
                        Student(name: name, mark: mark, id: student?.id);

                    if (student == null) {
                      await db.addStudent(std);
                    } else {
                      await db.updateStudent(std);
                    }

                    Navigator.pop(context);
                  },
                  child: Text(
                    student == null ? 'Save' : 'Edit',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
