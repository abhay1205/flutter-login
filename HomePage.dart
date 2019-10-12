import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;
  bool isSignedIn = false;
  String imageUrl;

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user){
      if(user == null){
        Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  getUser() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if(firebaseUser != null){
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
        this.imageUrl = user.photoUrl;
      });
    }
    print("${user.displayName} is the user ${user.photoUrl}");
  }

  signout() async{
    _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: !isSignedIn // setting isSignedIn to true
          ?CircularProgressIndicator()
          :Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 80),),
              CircleAvatar(
                backgroundImage: user.photoUrl!=null?NetworkImage("${user.photoUrl}"):AssetImage('asset/index.png'),
                maxRadius: 40,
                minRadius: 30,
              ),
              Container(
                padding: EdgeInsets.all(50),
                child: Text("Hello ${user.displayName==null?user.email: user.displayName} you are logged in ", style: TextStyle(fontSize: 20),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    color: Colors.blue,
                    onPressed: signout,
                    child:Text('Log Out', style: TextStyle(fontSize: 20, color: Colors.white),) ,),
              )
            ],
          ),
        ),
      ),
    );
  }
}