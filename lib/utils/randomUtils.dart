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
    List<int> arr = [];
    arr.add(randomInRange(start, end));

    for (int i = 1; i < size; i++) {
      int rand = randomInRange(start, end);
      while (arr.contains(rand)) {
        rand = randomInRange(start, end);
      }
      arr.add(rand);
    }

    return arr;
  }

  static int randomInRange(int start, int end) {
    Random random = Random();
    return random.nextInt(end-start) + start;
  }

  static List<List<int>> nRandomDistinctLists(int n, int size, int start, int end){
    List<List<int>> arr = [];
    arr.add(randomListInRange(size, start, end));

    bool flag = false;
    for (int i = 1; i < n; i++) {
      List<int> rand = [];
      do {
        rand = randomListInRange(size, start, end);
        flag = false;
        for (int j = 0; j < arr.length; j++){
          if (Set.from(rand).containsAll(arr[j]) && Set.from(arr[j]).containsAll(rand)) {
            flag = true;
            break;
          }
        }
      } while (flag);

      arr.add(rand);
    }

    return arr;
  }
}