import 'package:cloud_firestore/cloud_firestore.dart';
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
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      // llamar singleton de CrearUsuarioProvider
      email: CrearUsuarioProvider().getEmail,
      password: CrearUsuarioProvider().getPassword,
    );
    print(">> USUARIO CREADO: ${credential.user!.email}!!");
  }

  Future<void> createUserDocument() async {
    print("Entró a crear documento");
    String _profilePhoto =
        "https://firebasestorage.googleapis.com/v0/b/auth-example-a3044.appspot.com/o/photos-aguacapi%2FdefaultProfile.png?alt=media&token=2b8453b1-02b7-49d4-b189-1d2cb1cdd3f3";

    Map<String, dynamic> _userData = {
      "email": CrearUsuarioProvider().getEmail,
      "username": CrearUsuarioProvider().getUsername,
      "password": CrearUsuarioProvider().getPassword,
      "profilePhoto": _profilePhoto,
      "createdAt": DateTime.now().toString().substring(0, 10),
      "sex": CrearUsuarioProvider().getSex,
      "region": CrearUsuarioProvider().getRegion,
      "physicalActivity": CrearUsuarioProvider().getActividadFisica,
      "birthDate": CrearUsuarioProvider().getSelectedDate,
      "rankingPermission": CrearUsuarioProvider().getPermisoRanking,
      "goal": 2000,
      "goalProgress": 0,
      "status": "Soy nuev@ en AguaCapi :)",
    };

    // Crear documento en firestore
    CollectionReference _newUser =
        FirebaseFirestore.instance.collection("usuarios-aguacapi");
    // Obtener el ID del usuario autenticado
    String _uid = FirebaseAuth.instance.currentUser!.uid;
    await _newUser.doc(_uid).set(_userData);
    print(">> DOCUMENTO CREADO: ${_uid}: ${CrearUsuarioProvider().getEmail}!!");
  }

  Future<void> signInWithFirebase() async {
    // Iniciar sesión con correo y contraseña
    print("Entró a login");
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      // Llamar singleton de LoginProvider
      email: LoginProvider().getEmail,
      password: LoginProvider().getPassword,
    );
    print(">> USUARIO LOGUEADO: ${credential.user!.email}!!");
  }

  Future<void> signOutFirebaseUser() async {
    // Cerrar sesión con Firebase
    await _auth.signOut();
  }
}
