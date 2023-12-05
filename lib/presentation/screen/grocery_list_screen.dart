import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/grocery_items_model.dart';
import 'package:shopping_list_app/presentation/screen/new_item_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({
    super.key,
  });

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<GroceryItemsModel> _groceryItems = [];
  bool _isLoading = true;
  String? _isError;

  void _loadState() async {
    try {
      final url = Uri.https(
          'flutter-shopping-list-ap-8ccfd-default-rtdb.firebaseio.com',
          'Shopping-list.json');
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _isError = 'Error while fetching data from server';
        });
      }
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
      }
      final Map<String, dynamic> listData = json.decode(response.body);

      final List<GroceryItemsModel> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere((categoryItem) =>
                item.value['category'] == categoryItem.value.title)
            .value;
        loadedItems.add(
          GroceryItemsModel(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void _addItem() async {
    final groceryItem = await Navigator.push<GroceryItemsModel>(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return const NewItemScreen();
        },
      ),
    );
    if (groceryItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(groceryItem);
    });
  }

  void _removeItem(GroceryItemsModel item) async {
    int index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https(
        'flutter-shopping-list-ap-8ccfd-default-rtdb.firebaseio.com',
        'Shopping-list/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  @override
  Widget build(BuildContext context) {
    //final groceryItems = ref.watch(groceryItemProvider);
    Widget content = const Center(
      child: Text('No items where added'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
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
      );
    }
    if (_isError != null) {
      content = Center(
        child: Text(_isError!),
      );
    }
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
        body: content);
  }
}
