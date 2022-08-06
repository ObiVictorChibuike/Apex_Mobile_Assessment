import '../../../../../app/utils/asset_path.dart';

class OnBoardingContents {
  final String title;
  final String image;
  final String desc;

  OnBoardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnBoardingContents> contents = [
  OnBoardingContents(
    title: "Track Your work and get the result",
    image: AssetPath.onBoarding1,
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnBoardingContents(
    title: "Stay organized with team",
    image: AssetPath.onBoarding3,
    desc: "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnBoardingContents(
    title: "Get notified when work happens",
    image: AssetPath.onBoarding3,
    desc: "Take control of notifications, collaborate live or on your own time.",
  ),
];