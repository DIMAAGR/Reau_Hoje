import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';

class MyProfileSettingsView extends StatefulWidget {
  @override
  _MyProfileSettingsViewState createState() => _MyProfileSettingsViewState();
}

class _MyProfileSettingsViewState extends State<MyProfileSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "My Profile",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 35,
                    fontWeight: FontWeight.w800),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Account Name: " + MyPreferences.getUserName()),
              onTap: () {
                changeMyName(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("My Wallet: " + MyPreferences.getWallet()),
              onTap: () {
                changeMyWallet(context);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  changeMyName(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Change My Name:"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: MyPreferences.getUserName(),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: ((mySubmit) async {
                    MyPreferences.setUserName(mySubmit);
                  }),
                ),
              ),
            ],
          );
        });
  }

  changeMyWallet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Change My Name:"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: MyPreferences.getWallet(),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: ((mySubmit) async {
                    MyPreferences.setWallet(mySubmit);
                  }),
                ),
              ),
            ],
          );
        });
  }
}
