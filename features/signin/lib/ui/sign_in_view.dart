import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as FBA;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin/model/user.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

import 'create_account.dart';
import 'feed.dart';
import 'upload_page.dart';

final auth = FBA.FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
final ref = FirebaseFirestore.instance.collection('users');

User currentUserModel;

Future<Null> _ensureLoggedIn(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    await googleSignIn.signIn();
    await tryCreateUserRecord(context);
  }

  if (auth.currentUser == null) {

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;

    final FBA.GoogleAuthCredential credential = FBA.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await auth.signInWithCredential(credential);
  }
}

Future<Null> _silentLogin(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;

  if (user == null) {
    user = await googleSignIn.signInSilently();
    await tryCreateUserRecord(context);
  }

  if (await auth.currentUser == null && user != null) {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;


    final FBA.GoogleAuthCredential credential = FBA.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await auth.signInWithCredential(credential);
  }


}
Future<void> tryCreateUserRecord(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    return null;
  }
  DocumentSnapshot userRecord = await ref.doc(user.id).get();
  if (userRecord.data() == null) {
    // no user record exists, time to create

    String userName = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Center(
            child: Scaffold(
                appBar: AppBar(
                  leading: Container(),
                  title: Text('Fill out missing data',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.white,
                ),
                body: ListView(
                  children: <Widget>[
                    Container(
                      child: CreateAccount(),
                    ),
                  ],
                )),
          )),
    );

    if (userName != null || userName.length != 0) {
      ref.doc(user.id).set({
        "id": user.id,
        "username": userName,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "followers": {},
        "following": {},
      });
    }
    userRecord = await ref.doc(user.id).get();
  }

  currentUserModel = User.fromDocument(userRecord);
  return null;
}

class SignInView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  HomePage(title: 'Test App');
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

PageController pageController;

class _HomePageState extends State<HomePage> {
  int _page = 0;
  bool triedSilentLogin = false;
  bool setupNotifications = false;
  bool firebaseInitialized = false;

  Scaffold buildLoginPage() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 240.0),
          child: Column(
            children: <Widget>[
              AppText(
                text:'Muli App',
                  textStyle: Style.fontNormal(color:Colors.black,size: 12.0),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 100.0)),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: login,
                child: AppText(
                  text:'Sign In',
                  textStyle: Style.fontNormal(color:Colors.black,size: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (triedSilentLogin == false) {
      silentLogin(context);
    }
    if (!firebaseInitialized) return CircularProgressIndicator();

    auth.authStateChanges().listen((event) {
      if (event == null) {
        silentLogin(context);
      }
    });

    return (googleSignIn.currentUser == null || currentUserModel == null)
        ? buildLoginPage()
        : Scaffold(
      body: PageView(
        children: [
          Feed(),
          Container(
            color: Colors.white,
            child: Uploader(),
          ),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: (_page == 1) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void login() async {
    await _ensureLoggedIn(context);
    setState(() {
      triedSilentLogin = true;
    });
  }


  void silentLogin(BuildContext context) async {
    await _silentLogin(context);
    setState(() {
      triedSilentLogin = true;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      setState(() {
        firebaseInitialized= true;
      });
    });
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}