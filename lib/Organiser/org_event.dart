import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrgEvent extends StatefulWidget {
  final String eventId;
  const OrgEvent({super.key, required this.eventId});

  @override
  State<OrgEvent> createState() => _OrgEventState();
}

class _OrgEventState extends State<OrgEvent> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int? selectedStage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Details")),
      body: Column(
        children: [
          // Top 2/3: Display event data
          Expanded(
            flex: 1,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("events")
                  .doc(widget.eventId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var data = snapshot.data!.data() as Map<String, dynamic>?;

                if (data == null)
                  return Center(child: Text("No Event Data Available"));

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(data['event_name'] ?? "No Name"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Organizer: ${data['organizer'] ?? 'Unknown'}"),
                          Text("Date: ${data['date'] ?? 'Not Set'}"),
                          Text("Stage: ${data['stage'] ?? 'Not Set'}"),
                          Text("Time: ${data['time'] ?? 'Not Set'}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: "Enter Date", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    hint: Text("Select Stage"),
                    value: selectedStage,
                    items: List.generate(5, (index) => index + 1)
                        .map((stage) => DropdownMenuItem(
                              value: stage,
                              child: Text("Stage $stage"),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStage = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                        labelText: "Enter Time", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: saveEvent, child: Text("Save")),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: updateEvent, child: Text("Update")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to Save Event Data
  void saveEvent() async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(widget.eventId)
        .update({
      'date': dateController.text,
      'stage': selectedStage,
      'time': timeController.text,
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Event Saved Successfully!")));
  }

  // Function to Update Event Data
  void updateEvent() async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(widget.eventId)
        .update({
      'date': dateController.text,
      'stage': selectedStage,
      'time': timeController.text,
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Event Updated Successfully!")));
  }
}
