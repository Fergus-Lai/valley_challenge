import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valley_challenge/components/color_button.dart';
import 'package:valley_challenge/components/dev_checkbox.dart';

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
  late bool developer = widget.user.data()?["role"] == "developer";

  Future<void> onChanged(bool isDev) async {
    setState(() {
      developer = isDev;
    });
    await widget.user.reference
        .update({"role": developer ? "developer" : "founder"});
  }

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
          // Welcome Text
          Text(
            "Welcome Back ${developer ? "Developer" : "Founder"}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // Name Row
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
          ),
          // Change Role
          DevCheckBox(developer: developer, onChanged: onChanged),
          // Sign Out
          ColorButton(
              disabled: false,
              onClick: FirebaseAuth.instance.signOut,
              text: "Sign Out")
        ],
      ),
    ));
  }
}
