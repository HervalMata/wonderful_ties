import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:wonderful_ties/helpers/firebase_errors.dart';
import 'package:wonderful_ties/models/user.dart';

class UserManager extends ChangeNotifier {

  User user;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;
  bool get adminEnabled => user != null && user.admin;
  bool _loadingFace = false;
  bool get loadingFace => _loadingFace;

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot docUser = await firestore.collection('users')
                  .document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      final docAdmin = await firestore.collection('admins').document(user.id).get();
      if(docAdmin.exists){
        user.admin = true;
      }
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> signUp({User user, Function onSuccess, Function onFail}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> facebookLogin({Function onSuccess, Function onFail}) async {
    loadingFace = true;
    final result = await FacebookLogin().logIn(['email', 'public_profile']);
    switch(result.status) {
      case FacebookLoginStatus.loggedIn:
        final credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token
        );
        final authResult = await auth.signInWithCredential(credential);
        if (authResult.user != null) {
          final firebaseUser = authResult.user;
          user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email
          );
          await user.saveData();
          onSuccess();
        }
        break;
    }
    loadingFace = false;
  }
}