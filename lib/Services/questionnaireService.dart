import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/questionnaire_answer.dart';

import 'api.dart';

class QuestionnaireService {
  Future<void> addQuestionnaireAnswer(
      QuestionnaireAnswer questionnaireAnswer) async {
    final response = await Api().post(
        "addQuestionnaireAnswer",
        jsonEncode(<String, dynamic>{
          'email': questionnaireAnswer.email,
          'answer': questionnaireAnswer.answer,
          'score': questionnaireAnswer.score,
          'domain': questionnaireAnswer.domain,
          'code': questionnaireAnswer.code,
          'order': questionnaireAnswer.questionIndex,
          'scale': questionnaireAnswer.scale
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getQuestions(String code) async {
    final response = await Api().get("getQuestions?code=$code");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> discardAllAnswers(String email, String code) async {
    final response = await Api().post("discardAllAnswers",
        jsonEncode(<String, dynamic>{'email': email, 'code': code}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getScore(
      String email, String code, String scale) async {
    final response =
        await Api().get("getScore?email=$email&code=$code&scale=$scale");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}