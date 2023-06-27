import 'package:flutter/material.dart';

import '../../../routes.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  void navigateToAddProductPage() {
    Navigator.of(context).pushNamed(Routes.addProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProductPage,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
