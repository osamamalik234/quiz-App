import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/component/question_card.dart';
import 'package:quiz_app/constant.dart';
import 'package:quiz_app/screens/question_progress_Controller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuestionProgressController questionController =
      Get.put(QuestionProgressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF808080),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          elevation: 4,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 17, color: Colors.white, letterSpacing: 1),
                ))
          ]),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: kGrayColor, width: 3)),
              child: GetBuilder<QuestionProgressController>(
                init: QuestionProgressController(),
                builder: (controller) {
                  return Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) => Container(
                          width:
                              constraints.maxWidth * controller.animation.value,
                          decoration: BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Positioned.fill(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(controller.animation.value * 60).round()} sec",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.lock_clock,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ))
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                        text:
                            "Question ${questionController.questionNumber.value}",
                        style: const TextStyle(
                            color: kGrayColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " /${questionController.question.length}",
                              style:
                                  const TextStyle(color: kGrayColor, fontSize: 22)),
                        ]),
                  ),
                )),
            const Divider(
              color: kGrayColor,
              thickness: 5.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: PageView.builder(
                     physics: const NeverScrollableScrollPhysics(),
                    controller: questionController.pageController,
                    onPageChanged: questionController.updateQuestionNo,
                    itemCount: questionController.question.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: QuestionCard(
                            questions: questionController.question[index],
                          ),
                        ))),
          ],
        ),
      )),
    );
  }
}
