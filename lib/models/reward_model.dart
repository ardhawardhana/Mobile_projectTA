class Reward {
  final String id;
  final String name;
  final String description;
  final String iconEmoji; // placeholder for iconPath asset
  final int pointsRequired;

  const Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
    required this.pointsRequired,
  });
}

class UserReward {
  final String id;
  final String userId;
  final String rewardId;
  final DateTime earnedAt;

  const UserReward({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.earnedAt,
  });
}

class LeaderboardEntry {
  final String userId;
  final String fullName;
  final String avatarUrl;
  final int points;
  final int level;

  const LeaderboardEntry({
    required this.userId,
    required this.fullName,
    required this.avatarUrl,
    required this.points,
    required this.level,
  });
}
