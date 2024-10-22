import 'package:api_simple/controller/post_controller.dart';
import 'package:api_simple/view/categorybutton.dart';
import 'package:api_simple/view/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Registering PostController with GetX for dependency management.
  final PostController postController = Get.put(PostController());

//Creating an observable string for managing the selected category using GetX.
  final RxString selectedCategory = ''.obs;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.short_text_sharp),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryButton(
                    label: "Lorem",
                    category: "lorem",
                    selectedCategory: selectedCategory,
                    postController: postController,
                  ),
                  CategoryButton(
                    label: "İpsum",
                    category: "ipsum",
                    selectedCategory: selectedCategory,
                    postController: postController,
                  ),
                  CategoryButton(
                    label: "JsonPlaceholder",
                    category: "jsonplaceholder",
                    selectedCategory: selectedCategory,
                    postController: postController,
                  ),
                  CategoryButton(
                    label: "Rutrum",
                    category: "rutrum",
                    selectedCategory: selectedCategory,
                    postController: postController,
                  ),
                  CategoryButton(
                    label: "Elementum",
                    category: "elementum",
                    selectedCategory: selectedCategory,
                    postController: postController,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (postController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: postController.posts.length,
                  itemBuilder: (context, index) {
                    var post = postController.posts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => PostDetailPage(
                              postId: index,
                            ));
                      },
                      child: SizedBox(
                        height: 200,
                        child: Card(
                          shadowColor: const Color.fromARGB(255, 180, 178, 178),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        post.thumbnail!,
                                        height: screenSize.height * 0.17,
                                        width: screenSize.height * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.title ?? 'No Title',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        post.content ?? 'No Content',
                                        style: const TextStyle(fontSize: 16),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
