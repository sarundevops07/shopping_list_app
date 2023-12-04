import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/grocery_items_model.dart';
import 'package:shopping_list_app/presentation/screen/new_item_screen.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({
    super.key,
  });

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItemsModel> _groceryItems = [];
  void _addItem() async {
    final newItem = await Navigator.push<GroceryItemsModel>(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return const NewItemScreen();
        },
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItemsModel item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final groceryItems = ref.watch(groceryItemProvider);
    Widget emptyIndicator = const Center(
      child: Text('No items where added'),
    );
    if (_groceryItems.isNotEmpty) {}
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _groceryItems.isEmpty
          ? emptyIndicator
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(_groceryItems[index].id),
                  onDismissed: (_) {
                    _removeItem(_groceryItems[index]);
                  },
                  child: ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: _groceryItems[index].category.color,
                    ),
                    title: Text(_groceryItems[index].name),
                    trailing: Text(
                      _groceryItems[index].quantity.toString(),
                    ),
                  ),
                );
              },
              itemCount: _groceryItems.length,
            ),
    );
  }
}
