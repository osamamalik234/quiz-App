import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constant.dart';
import 'package:quiz_app/screens/question_progress_Controller.dart';

class Options extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback onPress;
  const Options(
      {super.key,
      required this.text,
      required this.index,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionProgressController>(
      init: QuestionProgressController(),
      builder: (QuestionProgressController controller) {
        Color getRightColorForAns() {
          if (controller.isAnswered) {
            if (index == controller.correctAns) {
              return kGreenColor;
            } else if (index == controller.selectedAns &&
                controller.selectedAns != controller.correctAns) {
              return kRedColor;
            }
          }
          return kGrayColor;
        }

        IconData getRightIcon() {
          return getRightColorForAns() == kRedColor ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: onPress,
          child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: getRightColorForAns()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}.  $text",
                    style: TextStyle(
                        color: getRightColorForAns() == kGrayColor
                            ? Colors.black
                            : getRightColorForAns(),
                        fontSize: 16,
                        fontFamily: "serif"),
                  ),
                  Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: getRightColorForAns() == kGrayColor
                              ? Colors.transparent
                              : getRightColorForAns(),
                          border: Border.all(
                              color: getRightColorForAns(), width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: getRightColorForAns() == kGrayColor
                          ? null
                          : Icon(
                              getRightIcon(),
                              size: 15,
                              color: Colors.white,
                            )),
                ],
              )),
        );
      },
    );
  }
}
