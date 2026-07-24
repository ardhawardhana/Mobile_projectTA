enum UserRole { student, teacher, admin }

class AppUser {
  final String uid;
  final String username;
  final String fullName;
  final UserRole role;
  final String className; // Firestore field `class` — reserved word in Dart
  final String tpqName;
  final int points;
  final int level;
  final int stars;
  final String avatarUrl;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.username,
    required this.fullName,
    required this.role,
    required this.className,
    required this.tpqName,
    required this.points,
    required this.level,
    required this.stars,
    required this.avatarUrl,
    required this.createdAt,
  });

  /// XP needed to reach the *next* level. Simple escalating curve:
  /// level N requires N * 100 points to complete.
  int get pointsForNextLevel => level * 100;

  /// Progress (0.0-1.0) through the current level, derived from points.
  double get levelProgress {
    final base = (level - 1) * 100;
    final into = (points - base).clamp(0, pointsForNextLevel);
    return into / pointsForNextLevel;
  }

  AppUser copyWith({int? points, int? level, int? stars}) {
    return AppUser(
      uid: uid,
      username: username,
      fullName: fullName,
      role: role,
      className: className,
      tpqName: tpqName,
      points: points ?? this.points,
      level: level ?? this.level,
      stars: stars ?? this.stars,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'fullName': fullName,
      'role': role.name,
      'class': className,
      'tpqName': tpqName,
      'points': points,
      'level': level,
      'stars': stars,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String uid) {
    return AppUser(
      uid: uid,
      username: map['username'] ?? '',
      fullName: map['fullName'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.student,
      ),
      className: map['class'] ?? '',
      tpqName: map['tpqName'] ?? '',
      points: (map['points'] ?? 0) as int,
      level: (map['level'] ?? 1) as int,
      stars: (map['stars'] ?? 0) as int,
      avatarUrl: map['avatarUrl'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
