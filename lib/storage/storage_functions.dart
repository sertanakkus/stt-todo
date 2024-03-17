import 'package:hive_flutter/hive_flutter.dart';

class StorageFunctions {
  final _lists = Hive.box('lists');

  Map getAllLists() {
    return _lists.toMap();
  }

  void addList(String name) {
    _lists.put(name, []);
  }

  void deleteList(String name) {
    _lists.delete(name);
  }

  void addItem(String listName, String item) {
    List list = _lists.get(listName);
    list.add(item);
  }
}
