import 'package:api_simple/controller/post_controller.dart';
import 'package:api_simple/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailPage extends StatefulWidget {
  final int? postId;

  PostDetailPage({required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  //Registering PostController with GetX for dependency management.
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Post>(
        future: postController.fetchPostById(widget.postId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final post = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  flexibleSpace: FlexibleSpaceBar(
                    background: post.thumbnail != null
                        ? Image.network(
                            post.thumbnail!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                  ),
                  pinned: true,
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.short_text_sharp),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              post.content ?? 'No Content',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
