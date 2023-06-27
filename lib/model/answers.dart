class Answers {
  final int answerId;
  final String answerText;
  final String score;
  final int domain;
  final int order;

  const Answers(
      {required this.answerId,
      required this.answerText,
      required this.score,
      required this.domain,
      required this.order});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      answerId: json['answerId'],
      answerText: json['answerText'],
      score: json['score'],
      domain: json['domain'],
      order: json['order'],
    );
  }
}
