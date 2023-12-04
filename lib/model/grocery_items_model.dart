import 'package:shopping_list_app/model/categories_model.dart';

class GroceryItemsModel {
  final String id;
  final String name;
  final int quantity;
  final CategoryModel category;

  GroceryItemsModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}
