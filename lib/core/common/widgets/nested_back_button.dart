import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        try {
          context.pop();
        } catch (_) {
          Navigator.pop(context);
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.pop(context);
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
