import 'dart:ui';
import 'package:flutter/material.dart';

class DreamInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmit;

  const DreamInput({
    super.key,
    required this.controller,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This padding moves the input down by 2 tile heights
      padding: const EdgeInsets.only(top: 32.0, left: 8.0, right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Expanded TextField
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Enter your dream...',
                      hintStyle: TextStyle(color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Submit Icon Button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white70),
                  onPressed: onSubmit ?? () {
                    debugPrint('Submitted dream: ${controller.text}');
                    // You can replace this with actual logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
