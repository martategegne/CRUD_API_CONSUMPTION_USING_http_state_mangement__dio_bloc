import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';

class LocalStorage {
  static const String key = "cached_posts";

  // Save posts
  Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data =
        posts.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  // Load posts
  Future<List<Post>> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((e) => Post.fromJson(jsonDecode(e)))
        .toList();
  }
}