import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  var taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(hintText: 'Recipe Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String title = taskController.text.trim();
                  String description = taskController.text.trim();
                  String ingredients = taskController.text.trim();

                  if (title.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please provide recipe name');
                    return;
                  } else if (description.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please provide description');
                    return;
                  } else if (ingredients.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please provide ingredients');
                    return;
                  }

                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    String uid = user.uid;
                    int dt = DateTime.now().millisecondsSinceEpoch;

                    DatabaseReference taskRef = FirebaseDatabase.instance
                        .ref()
                        .child('recipe')
                        .child(uid);

                    String? recipeId = taskRef.push().key;

                    await taskRef.child(recipeId!).set({
                      'dt': dt,
                      'title': title,
                      'description': description,
                      'ingredients': ingredients,
                      'recipeId': recipeId,
                    });
                  }
                },
                child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
