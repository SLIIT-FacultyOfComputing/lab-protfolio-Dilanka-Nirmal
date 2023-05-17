// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_lab_test_01/models/recipe_model.dart';

class UpdateRecipeScreen extends StatefulWidget {
  final RecipeModel task;

  const UpdateRecipeScreen({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateRecipeScreenState createState() => _UpdateRecipeScreenState();
}

class _UpdateRecipeScreenState extends State<UpdateRecipeScreen> {
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.task.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Recipe title'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var title = nameController.text.trim();
                  if (title.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please provide recipe name');
                    return;
                  }

                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    DatabaseReference taskRef = FirebaseDatabase.instance
                        .ref()
                        .child('tasks')
                        .child(user.uid)
                        .child(widget.task.recipeId);

                    await taskRef.update({
                      'title': title,
                    });
                  }
                },
                child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}
