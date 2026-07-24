import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/question_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions;
  int _index = 0;
  int? _selected;
  bool _answered = false;
  int _correctCount = 0;

  @override
  void initState() {
    super.initState();
    _questions = MockData.getQuestionsForCategory(widget.category.id);
  }

  QuizQuestion get _current => _questions[_index];

  void _selectOption(int i) {
    if (_answered) return;
    setState(() {
      _selected = i;
      _answered = true;
      if (i == _current.correctOptionIndex) _correctCount++;
    });
  }

  void _next() {
    if (_index == _questions.length - 1) {
      final result = MockData.buildResult(
        categoryId: widget.category.id,
        correctCount: _correctCount,
        totalCount: _questions.length,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            category: widget.category,
            result: result,
          ),
        ),
      );
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_index + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: AppColors.ink),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: AppColors.surfaceMuted,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('${_index + 1}/${_questions.length}',
                      style: AppText.caption),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text(
                  '${widget.category.iconEmoji}  ${widget.category.name}',
                  style: AppText.caption.copyWith(color: AppColors.primaryDark),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(_current.questionText, style: AppText.h1),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: ListView.separated(
                  itemCount: _current.options.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    return _OptionButton(
                      label: _current.options[i],
                      letter: String.fromCharCode(65 + i), // A, B, C, D
                      state: _optionState(i),
                      onTap: () => _selectOption(i),
                    );
                  },
                ),
              ),
              if (_answered) ...[
                if (_selected != _current.correctOptionIndex && _current.explanation != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    color: AppColors.dangerLight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline_rounded, color: AppColors.danger),
                            const SizedBox(width: 8),
                            Text(
                              'Pembahasan',
                              style: AppText.h2.copyWith(color: AppColors.danger),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _current.explanation!,
                          style: AppText.body.copyWith(color: AppColors.ink),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: Text(
                      _index == _questions.length - 1
                          ? 'Lihat Hasil'
                          : 'Lanjut',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _OptionState _optionState(int i) {
    if (!_answered) return _OptionState.idle;
    if (i == _current.correctOptionIndex) return _OptionState.correct;
    if (i == _selected) return _OptionState.wrong;
    return _OptionState.disabled;
  }
}

enum _OptionState { idle, correct, wrong, disabled }

class _OptionButton extends StatelessWidget {
  final String label;
  final String letter;
  final _OptionState state;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.letter,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color letterBg;
    Color letterFg;

    switch (state) {
      case _OptionState.idle:
        bg = AppColors.surfaceMuted;
        border = Colors.transparent;
        letterBg = AppColors.surface;
        letterFg = AppColors.ink;
        break;
      case _OptionState.correct:
        bg = AppColors.successLight;
        border = AppColors.success;
        letterBg = AppColors.success;
        letterFg = Colors.white;
        break;
      case _OptionState.wrong:
        bg = AppColors.dangerLight;
        border = AppColors.danger;
        letterBg = AppColors.danger;
        letterFg = Colors.white;
        break;
      case _OptionState.disabled:
        bg = AppColors.surfaceMuted;
        border = Colors.transparent;
        letterBg = AppColors.surface;
        letterFg = AppColors.inkSoft;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.md),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: border, width: 1.6),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: letterBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(letter,
                    style: AppText.numeric
                        .copyWith(color: letterFg, fontSize: 14)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(label, style: AppText.body)),
              if (state == _OptionState.correct)
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.success),
              if (state == _OptionState.wrong)
                const Icon(Icons.cancel_rounded, color: AppColors.danger),
            ],
          ),
        ),
      ),
    );
  }
}
