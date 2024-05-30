class Log {
  static void red(String msg) {
    print('\x1B[31m$msg\x1B[0m');
  }

  static void green(String msg) {
    print('\x1B[32m$msg\x1B[0m');
  }

  static void yellow(String msg) {
    print('\x1B[33m$msg\x1B[0m');
  }

  static void cyan(String msg) {
    print('\x1B[36m$msg\x1B[0m');
  }

  static void pink(String msg){
    print('\x1B[35m$msg\x1B[0m');
  }
}