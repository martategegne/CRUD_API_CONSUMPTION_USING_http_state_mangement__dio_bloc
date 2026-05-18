import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_event.dart';
import '../models/post_model.dart';

class AddEditScreen extends StatefulWidget {
  final Post? post;

  const AddEditScreen({super.key, this.post});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.post?.title ?? '');
    bodyController =
        TextEditingController(text: widget.post?.body ?? '');
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final post = Post(
        id: widget.post?.id,
        title: titleController.text,
        body: bodyController.text,
      );

      if (widget.post == null) {
        context.read<PostBloc>().add(AddPost(post));
      } else {
        context.read<PostBloc>().add(UpdatePostEvent(post));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.post != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA), // soft background

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6366F1),
        title: Text(
          isEdit ? "Edit Memory" : "Add Memory",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TITLE
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter title" : null,
                ),

                const SizedBox(height: 15),

                
                TextFormField(
                  controller: bodyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Body",
                    prefixIcon: const Icon(Icons.notes),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter content" : null,
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: submit,
                    child: Text(
                      isEdit ? "Update Memory" : "Add Memory",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}