import 'package:flutter/material.dart';

class MicButton extends StatelessWidget {
  const MicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white54, width: 2),
      ),
      padding: const EdgeInsets.all(18),
      child: IconButton(
        icon: const Icon(Icons.mic, color: Colors.white, size: 46),
        onPressed: () {
          // TODO: Add mic recording functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Voice input coming soon...")),
          );
        },
      ),
    );
  }
}
