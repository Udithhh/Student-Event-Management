import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignPage extends StatefulWidget {
  const AssignPage({super.key});

  @override
  State<AssignPage> createState() => _AssignPageState();
}

class _AssignPageState extends State<AssignPage> {
  final TextEditingController eventController = TextEditingController();
  String? selectedOrganizer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assign Event")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: eventController,
                decoration: InputDecoration(
                  labelText: "Event Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("organizer")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var organizers = snapshot.data!.docs;

                  if (organizers.isEmpty) {
                    return Text("No organizers available.");
                  }

                  return DropdownButtonFormField<String>(
                    value: selectedOrganizer,
                    hint: Text("Select Organizer"),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: organizers.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return DropdownMenuItem<String>(
                        value: data['name'],
                        child: Text(data['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOrganizer = value;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: addEvent,
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() async {
    if (eventController.text.isEmpty || selectedOrganizer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter event name and select an organizer.")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection("events").add({
      'event_name': eventController.text,
      'organizer': selectedOrganizer,
      'created_at': Timestamp.now(),
    });

    eventController.clear();
    setState(() {
      selectedOrganizer = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Event Added Successfully!")),
    );
  }
}
