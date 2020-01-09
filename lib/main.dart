import 'package:flutter/material.dart';
import 'package:flutter_app/ListViewJsonapi.dart';
import 'package:github/github.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GitHub Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: MyHomePage(title: 'Flutter GitHub Demo Home Page'),
      home: ListViewJsonApi(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _repoName ="Press Sync button to connect to GitHub";

  Future<void> mainGithub() async {
    /* Create a GitHub Client, with anonymous authentication by default

*/
    /*
  or Create a GitHub Client and have it try to find your token or credentials automatically
  In Flutter and in server environments this will search environment variables in this order
  GITHUB_ADMIN_TOKEN
  GITHUB_DART_TOKEN
  GITHUB_API_TOKEN
  GITHUB_TOKEN
  HOMEBREW_GITHUB_API_TOKEN
  MACHINE_GITHUB_API_TOKEN
  and then GITHUB_USERNAME and GITHUB_PASSWORD

  In a browser it will search keys in the same order first through the query string parameters
  and then in window sessionStorage

   or Create a GitHub Client using a username and password
    var github = GitHub(auth: Authentication.basic('deepandroid', 'deepravi13182111')); */
    var github = GitHub();
    Repository repo = await github.repositories.getRepository(RepositorySlug('deepandroid', 'github-integration-flutter'));
    /* Do Something with repo */
    setState(() {
      _repoName = repo.fullName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
            '$_repoName',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mainGithub();
        },
        tooltip: 'Github API calling',
        child: Icon(Icons.cached),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

