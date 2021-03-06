import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class APIService {
  static APIService? _apiService;

  APIService._internal();

  factory APIService() {
    _apiService = APIService._internal();
    return _apiService!;
  }

  /// Google
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentGoogleUser;
  GoogleSignIn? googleSignIn;
  GoogleSignInAccount? googleSignInAccount;
  UserCredential? userCredential;
  late AuthCredential credential;
  GoogleSignInAuthentication? googleSignInAuthentication;

  User? get googleUser => currentGoogleUser;

  Future<User?> signInWithGoogle() async {
    auth = FirebaseAuth.instance;

    googleSignIn = GoogleSignIn();
    googleSignInAccount = await googleSignIn?.signIn();

    if (googleSignInAccount != null) {
      googleSignInAuthentication = await googleSignInAccount?.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      try {
        userCredential = await auth.signInWithCredential(credential);

        currentGoogleUser = userCredential?.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
        throw e;
      }
    }

    return currentGoogleUser;
  }

  /// Facebook
  // Create an instance of FacebookLogin
  late FacebookLogin facebookLogin;
  late FacebookLoginResult facebookLoginResult;

  Future<FacebookLoginStatus> signInWithFacebook() async {
    facebookLogin = FacebookLogin();
    facebookLoginResult = await facebookLogin.logIn();

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancel:
        print("CancelledByUser");
        return FacebookLoginStatus.cancel;
      case FacebookLoginStatus.success:
        print("LoggedIn");
        return FacebookLoginStatus.success;
      default:
        print("Error");
        return FacebookLoginStatus.error;
    }
  }

  Future<String?> getFacebookUserPhotoURL() async {
    final imageUrl = await facebookLogin.getProfileImageUrl(width: 100);
    return imageUrl;
  }

  Future<String?> getFacebookUserProfileName() async {
    // Get profile data
    final profile = await facebookLogin.getUserProfile();
    return profile?.name;
  }

  Future<void> googleSignOut() async {
    auth.signOut();
    googleSignIn?.signOut();
  }

  Future<void> facebookSignOut() async {
    facebookLogin.logOut();
  }
}
