import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digikos_mobile/models/user_model.dart';
import 'package:digikos_mobile/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ), //appbar
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Image.asset("assets/digikos_logo.png",
                          fit: BoxFit.contain),
                    ),
                    const Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("${loggedInUser.email}",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    ActionChip(
                        label: const Text("Logout"),
                        onPressed: (() {
                          logout(context);
                        }))
                  ]))),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((uid) => {
          Fluttertoast.showToast(msg: 'Berhasil Logout'),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()))
        });
  }
}