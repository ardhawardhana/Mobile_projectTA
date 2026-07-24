class QuizCategory {
  final String id;
  final String name;
  final String description;
  final String iconEmoji; // placeholder for an illustration/icon asset

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
  });
}

class QuizQuestion {
  final String id;
  final String categoryId;
  final String questionText;
  final List<String> options; // exactly 4: A, B, C, D
  final int correctOptionIndex; // 0-3
  final String? explanation;

  const QuizQuestion({
    required this.id,
    required this.categoryId,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });
}
