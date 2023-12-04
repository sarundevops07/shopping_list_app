import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/categories_model.dart';

final categories = {
  Categories.vegetables: CategoryModel(
    'Vegetables',
    const Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: CategoryModel(
    'Fruit',
    const Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: CategoryModel(
    'Meat',
    const Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: CategoryModel(
    'Dairy',
    const Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: CategoryModel(
    'Carbs',
    const Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: CategoryModel(
    'Sweets',
    const Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: CategoryModel(
    'Spices',
    const Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: CategoryModel(
    'Convenience',
    const Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: CategoryModel(
    'Hygiene',
    const Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: CategoryModel(
    'Other',
    const Color.fromARGB(255, 0, 225, 255),
  ),
};
