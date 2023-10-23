import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController =
      TextEditingController(text: widget.user.data()?["name"]);
  bool nameEdit = false;
  String? nameError;

  Future<void> nameButtonPressed() async {
    if (nameEdit) {
      if (nameController.text.isEmpty) {
        setState(() {
          nameError = "Name Can Not Be Empty";
        });
        return;
      }
      await widget.user.reference.update({"name": nameController.text});
    }
    setState(() {
      nameEdit = !nameEdit;
    });
  }

  @override
  Widget build(context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                child: TextField(
                  enabled: nameEdit,
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {
                      nameError =
                          value.isEmpty ? "Name Can Not Be Empty" : null;
                    });
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Name"),
                      errorText: nameError),
                ),
              ),
              TextButton(
                  onPressed: nameButtonPressed,
                  child: Icon(nameEdit ? Icons.save : Icons.edit, size: 40))
            ],
          )
        ],
      ),
    ));
  }
}
