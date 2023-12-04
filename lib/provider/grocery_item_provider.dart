import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/dummy_items.dart';

final groceryItemProvider = Provider((ref) {
  return groceryItems;
});
