import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Passing and Returning Data',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  Future<void> _openDetails(BuildContext context, String productName) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productName: productName),
      ),
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> products = [
      "Laptop",
      "Smart Phone",
      "Headphones",
      "Smart Watch",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Product List"), centerTitle: true),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(products[index]),
              onTap: () {
                _openDetails(context, products[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String productName;

  const ProductDetailsScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, size: 100, color: Colors.blue),
              const SizedBox(height: 20),

              Text(
                productName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton.icon(
                label: const Text(
                  "Add to Favorites",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context, "$productName Added to Favorites");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
