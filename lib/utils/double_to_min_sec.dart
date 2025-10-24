String doubleTominSec(int durationInMiliSeconds) {
  int min = (durationInMiliSeconds / 1000) ~/ 60;
  int sec = (durationInMiliSeconds / 1000).toInt() % 60;
  return '${min} : ${sec.toString().padLeft(2, '0')}';
}
