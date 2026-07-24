class DailyChallenge {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final int pointsReward;
  final double progress; // 0.0 to 1.0
  final bool isCompleted;
  final bool isClaimed;

  const DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.pointsReward,
    required this.progress,
    required this.isCompleted,
    this.isClaimed = false,
  });

  DailyChallenge copyWith({
    bool? isClaimed,
  }) {
    return DailyChallenge(
      id: id,
      title: title,
      description: description,
      iconEmoji: iconEmoji,
      pointsReward: pointsReward,
      progress: progress,
      isCompleted: isCompleted,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}
