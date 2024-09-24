import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/appBar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ActionScreen();
  }
}

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  _ActionScreenState createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  final TextEditingController _actionController = TextEditingController();
  late Box actionBox;

  @override
  void initState() {
    super.initState();

    // Get the already opened box
    actionBox = Hive.box('actionsBox');
  }

  // Function to save data to Hive box
  void _saveAction() {
    String action = _actionController.text;

    if (action.isNotEmpty) {
      actionBox.put(action, false); // Save with default 'completed' as false
      _actionController.clear(); // Clear the text field after saving
      setState(() {}); // Refresh UI (if necessary)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Actions Manager'
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _actionController,
              decoration: InputDecoration(labelText: 'Enter Action'),
            ),
            SizedBox(height: 20),

            // Button to save data to Hive
            ElevatedButton(
              onPressed: _saveAction, // Call _saveAction when pressed
              child: Text('Save Action'),
            ),

            SizedBox(height: 20),

            // Display saved actions from Hive
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: actionBox.listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      String action = box.keyAt(index);
                      bool completed = box.get(action);

                      return CheckboxListTile(
                        title: Text(action),
                        value: completed,
                        onChanged: (value) {
                          box.put(action, value); // Update action status
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}