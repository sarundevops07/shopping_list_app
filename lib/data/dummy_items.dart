import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/categories_model.dart';
import 'package:shopping_list_app/model/grocery_items_model.dart';

final groceryItems = [
  GroceryItemsModel(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItemsModel(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItemsModel(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
