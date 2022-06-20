import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digikos_mobile/models/kosan_model.dart';
import 'package:digikos_mobile/models/user_model.dart';
import 'package:digikos_mobile/screens/kosan/kosan_screen.dart';
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
      print(loggedInUser.firstName);
      setState(() {});
    });
  }

  Stream<List<KosanModel>> readKosan() => FirebaseFirestore.instance
      .collection("datakosan")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => KosanModel.fromMap(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Digikos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ))
        ],
      ), //appbar
      body: StreamBuilder<List<KosanModel>>(
          stream: readKosan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final kost = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: kost!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KostDetail(
                                kost: kost[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              Image.network(
                                kost[index].gambar_kosan!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                kost[index].nama_kosan!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
