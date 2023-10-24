import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valley_challenge/components/dev_checkbox.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  final nameController = TextEditingController();
  bool developer = true;
  String? nameError;

  void onChanged(bool isDev) {
    setState(() {
      developer = isDev;
    });
  }

  Future<void> confirmPressed() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .set({
      "name": nameController.text,
      "role": developer ? "developer" : "founder"
    });
  }

  bool disable() {
    return nameError != null || nameController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      nameError = null;
                    });
                  } else {
                    setState(() {
                      nameError = "Name Can Not Be Empty";
                    });
                  }
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Name"),
                    errorText: nameError),
              ),
              const SizedBox(height: 8),
              DevCheckBox(developer: developer, onChanged: onChanged),
              const SizedBox(height: 8),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: disable()
                          ? const MaterialStatePropertyAll(Colors.grey)
                          : const MaterialStatePropertyAll(Colors.purple),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: disable() ? null : confirmPressed,
                  child: const Center(
                    child: (Text("Confirm")),
                  ))
            ],
          )),
    );
  }
}
