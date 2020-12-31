import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalUsers extends StatefulWidget {
  @override
  _TotalUsersState createState() => _TotalUsersState();
}

class _TotalUsersState extends State<TotalUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, userSnapshots) {
          if (userSnapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final userDocs = userSnapshots.data.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 6.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userDocs[index].data()['photoUrl']),
                        ),
                        title: Text(userDocs[index].data()['displayName']),
                        trailing: Text(userDocs[index].data()['tag']),
                      ),
                    ),
                    itemCount: userDocs.length,
                  ),
                ),
                Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total Users:',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userDocs.length.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ],
            ),
          );
        });
  }
}
