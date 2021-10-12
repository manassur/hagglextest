import 'package:hive/hive.dart';

class AppCache {
  static void saveUser(user) {
    var box = Hive.box('appBox');
    box.put('user', user);
    // use this to get the user
    //var name = box.get('name');
  }
}
