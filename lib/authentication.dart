import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooogleSignIn = GoogleSignIn();

Future<bool> googleSignIn() async {
  try {
    GoogleSignInAccount googleSignInAccount = await gooogleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final UserCredential result = await auth.signInWithCredential(credential);

      User user = await auth.currentUser;
      print(user.displayName);

      return Future.value(true);
    }
  } catch (error) {
    print(error);
  }
}
