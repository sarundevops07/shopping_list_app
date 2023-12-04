import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/provider/grocery_item_provider.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceryItemProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Groceries'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: groceryItems[index].category.color,
            ),
            title: Text(groceryItems[index].name),
            trailing: Text(
              groceryItems[index].quantity.toString(),
            ),
          );
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
