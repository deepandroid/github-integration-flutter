import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewJsonApi extends StatefulWidget {
  _ListViewJsonApiState createState() => _ListViewJsonApiState();
}

class _ListViewJsonApiState extends State<ListViewJsonApi> {
  final String uri =
      'http://api.github.com/repos/deepandroid/github-integration-flutter/commits';
                          // GitHub Username : deepandroid
                          // GitHub Repo(Public)  : github-integration-flutter

  Future<List<Commits>> _list;
  Future<List<Commits>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Commits> listOfUsers = items.map<Commits>((json) {
        return Commits.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _list = _fetchUsers();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching Commits from GitHub'),
      ),
      body: FutureBuilder<List<Commits>>(
        future: _list,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Commits commits = snapshot.data[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              commits.commit.author.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            Divider(
                              height: 5,
                              color: Colors.white,
                            ),
                            Text(
                                commits.commit.message
                            ),
                            Divider(
                              height: 5,
                              color: Colors.white,
                            ),
                            Text(
                                commits.commit.author.date.replaceAll("T"," ").replaceAll("Z", "")
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _list = _fetchUsers();
            print(_list);
          });
        },
        tooltip: 'Github API calling',
        child: Icon(Icons.cached),
      ),
    );
  }
}

class Commits {
  String sha;
  Commit commit;
  String nodeId;

  Commits({
    this.sha,
    this.commit,
    this.nodeId,
  });

  factory Commits.fromJson(Map<String, dynamic> json) {
    return Commits(
      sha: json['sha'],
      commit: Commit.fromJson(json["commit"]),
      nodeId: json['node_id'],
    );
  }
}

class Commit {
  Author author;
  String message;

  Commit({this.author, this.message});

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      author: Author.fromJson(json['author']),
      message: json['message'],
    );
  }
}

class Author {
  String name;
  String date;

  Author({this.name, this.date});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      date: json['date'],
    ); // Author
  }
}
