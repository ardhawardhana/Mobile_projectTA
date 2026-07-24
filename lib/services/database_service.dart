import 'package:firebase_database/firebase_database.dart';
import '../models/test_result_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  /// Save a brand-new user profile (called right after signUp)
  Future<void> saveNewUserProfile(AppUser user) async {
    await _db.child('users/${user.uid}').set(user.toMap());
  }

  /// Stream user profile in real-time
  Stream<AppUser?> streamUserProfile(String uid) {
    return _db.child('users/$uid').onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw != null && raw is Map) {
        return AppUser.fromMap(Map<String, dynamic>.from(raw), uid);
      }
      return null;
    });
  }

  /// Get single user profile snapshot
  Future<AppUser?> getUserProfile(String uid) async {
    final snapshot = await _db.child('users/$uid').get();
    if (snapshot.exists && snapshot.value != null) {
      return AppUser.fromMap(
        Map<String, dynamic>.from(snapshot.value as Map),
        uid,
      );
    }
    return null;
  }

  /// Save quiz result
  Future<void> saveTestResult(TestResult result) async {
    final newRef = _db.child('test_results').push();
    await newRef.set({
      'userId': result.userId,
      'categoryId': result.categoryId,
      'score': result.score,
      'correctCount': result.correctCount,
      'wrongCount': result.wrongCount,
      'starsEarned': result.starsEarned,
      'createdAt': result.createdAt.toIso8601String(),
    });
  }

  /// Update user points, stars, and level (atomic, safe from race conditions)
  Future<void> addPointsAndStars(
    String uid, {
    required int pointsToAdd,
    required int starsToAdd,
  }) async {
    final userRef = _db.child('users/$uid');

    await userRef.runTransaction((Object? currentData) {
      if (currentData == null) {
        return Transaction.success(currentData);
      }

      final data = Map<String, dynamic>.from(currentData as Map);
      final currentPoints = (data['points'] ?? 0) as int;
      final currentStars = (data['stars'] ?? 0) as int;

      final newPoints = currentPoints + pointsToAdd;
      final newStars = currentStars + starsToAdd;

      // Calculate new level: level N requires N * 100 points
      int newLevel = 1;
      while (newPoints >= newLevel * 100) {
        newLevel++;
      }

      data['points'] = newPoints;
      data['stars'] = newStars;
      data['level'] = newLevel;

      return Transaction.success(data);
    });
  }

  /// Stream top users for leaderboard, ordered highest points first
  Stream<List<AppUser>> streamLeaderboard({int limit = 20}) {
    return _db
        .child('users')
        .orderByChild('points')
        .limitToLast(limit)
        .onValue
        .map((event) {
      final raw = event.snapshot.value;
      if (raw == null) return <AppUser>[];

      final map = Map<String, dynamic>.from(raw as Map);
      final list = map.entries
          .map((e) => AppUser.fromMap(
                Map<String, dynamic>.from(e.value as Map),
                e.key,
              ))
          .toList();

      // RTDB's limitToLast returns ascending order (lowest points first),
      // so reverse to get highest points first for the leaderboard.
      list.sort((a, b) => b.points.compareTo(a.points));
      return list;
    });
  }
}