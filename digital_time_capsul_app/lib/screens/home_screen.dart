import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_event.dart';
import '../bloc/post/post_state.dart';
import '../widgets/post_card.dart';
import 'add_edit_screen.dart';
import '../models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6366F1),
        title: const Text(
          "Digital Time Capsule",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

       
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search memories...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

        
          Expanded(
            child: BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },

              builder: (context, state) {
             
                if (state is PostLoading &&
                    context.read<PostBloc>().currentPosts.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Post> posts =
                    context.read<PostBloc>().currentPosts;

                final filteredPosts = posts.where((post) {
                  return post.title
                          .toLowerCase()
                          .contains(searchQuery) ||
                      post.body.toLowerCase().contains(searchQuery);
                }).toList();

                if (filteredPosts.isEmpty) {
                  return const Center(
                    child: Text("No memories found"),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PostBloc>().add(LoadPosts());
                  },

                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredPosts.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),

                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];

                      return AnimatedContainer(
                        duration:
                            Duration(milliseconds: 200 + (index * 40)),
                        curve: Curves.easeOut,

                        child: PostCard(
                          post: post,

                          onDelete: () {
                            context
                                .read<PostBloc>()
                                .add(DeletePostEvent(post.id!));
                          },

                          onEdit: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    AddEditScreen(post: post),
                                transitionsBuilder:
                                    (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ➕ FLOATING ACTION BUTTON (UNCHANGED THEME)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6366F1),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddEditScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}