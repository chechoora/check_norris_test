import 'package:flutter/material.dart';

class DisplayErrorWidget extends StatelessWidget {
  const DisplayErrorWidget({
    required this.errorText,
    this.onRetryRequested,
    super.key,
  });

  final String errorText;
  final VoidCallback? onRetryRequested;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorText),
          ElevatedButton(
            onPressed: onRetryRequested,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
