import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = '\categoryscreen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Category',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
