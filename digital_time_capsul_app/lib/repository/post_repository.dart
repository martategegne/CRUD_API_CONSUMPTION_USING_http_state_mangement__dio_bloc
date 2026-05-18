import '../models/post_model.dart';
import '../services/api_service.dart';
import '../services/local_storage.dart';

class PostRepository {
  final ApiService apiService;
  final LocalStorage localStorage = LocalStorage();

  PostRepository(this.apiService);

  // FETCH (API + LOCAL MERGE)
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await apiService.getPosts();
      List data = response.data['posts'];

      final apiPosts = data.map((e) => Post.fromJson(e)).toList();

      final localPosts = await localStorage.loadPosts();

      //  Keep only local posts that are NOT in API
      final localOnlyPosts = localPosts.where((localPost) {
        return !apiPosts.any((apiPost) => apiPost.id == localPost.id);
      }).toList();

      final mergedPosts = [...localOnlyPosts, ...apiPosts];

      await localStorage.savePosts(mergedPosts);

      return mergedPosts;

    } catch (e) {
      return await localStorage.loadPosts();
    }
  }

  // ADD (UNIQUE LOCAL ID)
  Future<Post> addPost(Post post) async {
    final response = await apiService.createPost(post.toJson());

    return Post(
      id: DateTime.now().millisecondsSinceEpoch, // 🔥 unique ID
      title: response.data['title'] ?? post.title,
      body: response.data['body'] ?? post.body,
    );
  }

  // UPDATE (API + FALLBACK)
  Future<Post> updatePost(Post post) async {
    try {
      final response =
          await apiService.updatePost(post.id!, post.toJson());

      return Post(
        id: post.id,
        title: response.data['title'] ?? post.title,
        body: response.data['body'] ?? post.body,
      );
    } catch (e) {
      return post; // fallback for local posts
    }
  }

  // DELETE (API + FALLBACK)
  Future<void> deletePost(int id) async {
    try {
      await apiService.deletePost(id);
    } catch (e) {
      // ignore (local delete still works)
    }
  }

  // CACHE
  Future<void> saveToCache(List<Post> posts) async {
    await localStorage.savePosts(posts);
  }
}