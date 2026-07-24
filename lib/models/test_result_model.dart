class TestResult {
  final String id;
  final String userId;
  final String categoryId;
  final int score; // 0-100
  final int correctCount;
  final int wrongCount;
  final int starsEarned; // 1-3
  final DateTime createdAt;

  const TestResult({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.score,
    required this.correctCount,
    required this.wrongCount,
    required this.starsEarned,
    required this.createdAt,
  });

  /// Star thresholds, made explicit so quiz_result_screen and
  /// database_service (later) agree on the same rule:
  ///  score >= 90 -> 3 stars, >= 70 -> 2 stars, >= 40 -> 1 star, else 0.
  static int starsForScore(int score) {
    if (score >= 90) return 3;
    if (score >= 70) return 2;
    if (score >= 40) return 1;
    return 0;
  }
}
