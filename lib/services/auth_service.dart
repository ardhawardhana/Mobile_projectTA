import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  /// Stream of Auth State changes to know if user is logged in or out
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Get current Firebase Auth user
  User? get currentUser => _auth.currentUser;

  /// Register a new user in Firebase Auth and save user profile to Realtime Database
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
    required String fullName,
    required String className,
    required String tpqName,
  }) async {
    try {
      // 1. Create Auth Account
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = credential.user!.uid;

      // 2. Create AppUser object
      final appUser = AppUser(
        uid: uid,
        username: username.trim(),
        fullName: fullName.trim(),
        role: UserRole.student,
        className: className.trim(),
        tpqName: tpqName.trim(),
        points: 0,
        level: 1,
        stars: 0,
        avatarUrl: '',
        createdAt: DateTime.now(),
      );

      // 3. Save to Realtime Database under 'users/{uid}'
      await _db.saveNewUserProfile(appUser);

      // 4. Sign out immediately — Firebase auto-signs-in after registration,
      // but we want the user to log in manually from the Login screen.
      await _auth.signOut();

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _getIndonesianErrorMessage(e.code);
    } catch (e) {
      throw 'Terjadi kesalahan saat pendaftaran: $e';
    }
  }

  /// Sign in with Email and Password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw _getIndonesianErrorMessage(e.code);
    } catch (e) {
      throw 'Terjadi kesalahan saat masuk: $e';
    }
  }

  /// Get current logged-in user's profile data (one-time fetch)
  Future<AppUser?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _db.getUserProfile(user.uid);
  }

  /// Stream version — auto-update UI kalau data user berubah
  /// (misal poin/level bertambah setelah selesai tes)
  Stream<AppUser?> get currentUserProfileStream {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);
    return _db.streamUserProfile(user.uid);
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Convert Firebase error codes to friendly Indonesian messages
  String _getIndonesianErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-disabled':
        return 'Akun ini telah dinonaktifkan.';
      case 'user-not-found':
        return 'Akun dengan email ini tidak ditemukan.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email atau kata sandi salah.';
      case 'email-already-in-use':
        return 'Email ini sudah terdaftar. Silakan gunakan email lain.';
      case 'weak-password':
        return 'Kata sandi terlalu lemah. Minimal 6 karakter.';
      default:
        return 'Gagal melakukan autentikasi ($code).';
    }
  }
}