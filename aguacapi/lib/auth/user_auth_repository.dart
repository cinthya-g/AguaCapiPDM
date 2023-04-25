import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:aguacapi/providers/crear_usuario_provider.dart';
import 'package:aguacapi/providers/login_provider.dart';

class UserAuthRepository {
  // Crear instancias de FirebaseAuth y GoogleSignIn
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // Crear métodos para el registro y login de usuarios

  bool isAlreadyAuthenticated() {
    // Verificar si el usuario ya está autenticado
    return _auth.currentUser != null;
  }

  Future<void> signInWithGoogle() async {
    // Iniciar sesión con Google
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    print(">> User name: ${googleUser.displayName}");

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOutGoogleUser() async {
    // Cerrar sesión con Google
    await _googleSignIn.signOut();
  }

  Future<void> createAccount() async {
    print("Entró a crear cuenta");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        // llamar singleton de CrearUsuarioProvider
        email: CrearUsuarioProvider().getEmail,
        password: CrearUsuarioProvider().getPassword,
      );
      print(">> USUARIO CREADO: ${credential.user!.email}!!");
    } on FirebaseAuthException catch (e) {
      print("No se creó nada, error");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("ERROR: ${e}");
    }
  }

  Future<void> signInWithFirebase() async {
    // Iniciar sesión con correo y contraseña
    print("Entró a login");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        // Llamar singleton de LoginProvider
        email: LoginProvider().getEmail,
        password: LoginProvider().getPassword,
      );
      print(">> USUARIO LOGUEADO: ${credential.user!.email}!!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOutFirebaseUser() async {
    // Cerrar sesión con Firebase
    await _auth.signOut();
  }
}
