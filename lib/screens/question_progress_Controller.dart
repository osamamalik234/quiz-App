import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/screens/score_screen.dart';

class QuestionProgressController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  Animation get animation => _animation!;

  PageController? _pageController;
  PageController get pageController => _pageController!;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        // it will update our progress bar
        update();
      });
    _animationController!.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _pageController!.dispose();
    super.dispose();
  }

  // add data in model

  final List<QuestionModel> _question = sampleData
      .map((question) => QuestionModel(
          id: question["id"],
          answer: question["answer_index"],
          question: question["question"],
          options: question["options"]))
      .toList();

  // make getter method to get question
  List<QuestionModel> get question => _question;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int get correctAns => _correctAns!;

  int? _selectedAns;
  int get selectedAns => _selectedAns!;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _noCorrectAns = 0;
  int get noCorrectAns => _noCorrectAns;

  // checking for answer
  void checkAns(QuestionModel question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _noCorrectAns++;
    _animationController!.stop();
    update();

    // once user select answer after 3 sec then it will move to next question
    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  // next question
  void nextQuestion() {
    // ignore: unrelated_type_equality_checks
    if (_questionNumber != _question.length) {
      _isAnswered = false;
      _pageController!.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);

      // reset the counter
      _animationController!.reset();

      // now start it again
      _animationController!.forward().whenComplete(nextQuestion);
    } else {
      Get.to(const Score());
    }
  }

  // update the question number

  void updateQuestionNo(int index) {
    _questionNumber.value = index + 1;
  }
}
