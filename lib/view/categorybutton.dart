import 'package:api_simple/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final String category;
  final RxString selectedCategory;
  final PostController postController;

  const CategoryButton({
    required this.label,
    required this.category,
    required this.selectedCategory,
    required this.postController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextButton(
          onPressed: () {
            selectedCategory.value = category;
            postController.fetchPostsByCategory(selectedCategory.value);
          },
          style: TextButton.styleFrom(
            foregroundColor: selectedCategory.value == category
                ? Colors.black
                : const Color.fromARGB(255, 159, 158, 158),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
        ));
  }
}
