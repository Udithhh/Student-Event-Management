import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrgHome extends StatefulWidget {
  const OrgHome({super.key});

  @override
  State<OrgHome> createState() => _OrgHomeState();
}

class _OrgHomeState extends State<OrgHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Organizer List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("organizer").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No organizers found."));
          }

          var organizers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: organizers.length,
            itemBuilder: (context, index) {
              var data = organizers[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name'] ?? "No Name"),
                subtitle: Text(data['email'] ?? "No Email"),
                leading: CircleAvatar(child: Icon(Icons.person)),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        },
      ),
    );
  }
}
