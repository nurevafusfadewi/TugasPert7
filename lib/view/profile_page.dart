import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pertemuan_tujuh/data/shared_pref.dart';
import 'package:pertemuan_tujuh/view/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: FutureBuilder<String>(
            future: SharedPref().getUsername(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text("${snapshot.data}");
            },
          ),
        ),
      ),
    );
  }
}
