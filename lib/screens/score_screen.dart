import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/question_progress_Controller.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionProgressController questionProgressController =
        Get.put(QuestionProgressController());
    return Scaffold(
      backgroundColor: const Color(0xFF808080),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Correct Answers:  ${questionProgressController.noCorrectAns}",
                style: constStlye,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Your Score",
                style: constStlye.copyWith(fontSize: 40),
              ),
              const SizedBox(
                height: 40,
              ),
              Text("${questionProgressController.noCorrectAns * 10} / 50",
                  style: constStlye.copyWith(fontSize: 50)),
                  SizedBox(height: 20,)
            ]),
          ),
          
        ),
      ),
    );
  }
}

TextStyle constStlye =
    const TextStyle(color: Colors.black, fontSize: 30, fontFamily: "serif");
