String getTimeForCountDown(int time) {
  int minute = (time / 60).floor();
  int seconds = time % 60;
  String one = minute < 10 ? '0$minute' : '$minute';
  String two = seconds < 10 ? '0$seconds' : '$seconds';
  return "$one:$two";
}