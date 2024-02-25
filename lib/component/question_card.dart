import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constant.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/screens/question_progress_Controller.dart';

import 'options.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questions;

  const QuestionCard({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    QuestionProgressController questionController =
        Get.put(QuestionProgressController());
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            questions.question,
            style: const TextStyle(
                fontSize: 17, fontFamily: "serif", color: kBlackColor),
          ),
          const SizedBox(
            height: 20,
          ),
          ...List.generate(
              questions.options.length,
              (index) => Options(
                  text: questions.options[index],
                  index: index,
                  onPress: () {
                    questionController.checkAns(questions, index);
                  }))
        ],
      ),
    );
  }
}
