import 'dart:math';

class RandomUtils {
  static List<int> randomList(int size) {
    Random random = Random();
    List<int> arr = [];
    arr.add(random.nextInt(size));

    for (int i = 1; i < size; i++) {
      int rand = random.nextInt(size);
      while (arr.contains(rand)) {
        rand = random.nextInt(size);
      }
      arr.add(rand);
    }

    return arr;
  }

  static List<int> randomListInRange(int size, int start, int end) {
    Random random = Random();
    List<int> arr = [];
    arr.add(random.nextInt(end) + start);

    for (int i = 1; i < size; i++) {
      int rand = random.nextInt(end) + start;
      while (arr.contains(rand)) {
        rand = random.nextInt(end) + start;
      }
      arr.add(rand);
    }

    return arr;
  }

  static int randomInRange(int start, int end) {
    Random random = Random();
    return random.nextInt(end) + start;
  }
}