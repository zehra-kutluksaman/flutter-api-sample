import 'package:api_simple/model/post_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PostController extends GetxController {
  var posts = <Post>[]
      .obs; // Creating an observable list of Post objects to hold all posts fetched from the API.
  var filteredPosts = <Post>[]
      .obs; // Creating an observable list of Post objects for storing posts that match the selected category.
  var isLoading = true
      .obs; // Creating an observable boolean to indicate the loading state of data fetching.

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  //Fetch all posts -> GET REQUEST
  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse('https://jsonplaceholder.org/posts'));
      if (response.statusCode == 200) {
        var jsonPosts = json.decode(response.body) as List;
        posts.value = jsonPosts.map((post) => Post.fromJson(post)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  //Fetch post -> GET BY ID REQUEST
  Future<Post> fetchPostById(int id) async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Fetch posts with query param -> FILTERING
  void fetchPostsByCategory(String category) async {
    isLoading(true);
    try {
      var response =
          await http.get(Uri.parse('https://jsonplaceholder.org/posts'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;

        // Kategoriye göre filtreleme
        posts.value = data
            .where((json) => (json['category'] as String)
                .toLowerCase()
                .contains(category.toLowerCase()))
            .map((json) => Post.fromJson(json))
            .toList();
      }
    } finally {
      isLoading(false);
    }
  }
}
