import 'package:flutter/material.dart';

class BranCard extends StatelessWidget {
  final String imageAssetPath;

  const BranCard({
    Key? key,
    required this.imageAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300), 
        color: Colors.white,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0), 
          child: Image.asset(
            imageAssetPath,
            width: 109, 
            height: 150,
            fit: BoxFit.contain, 
          ),
        ),
      ),
    );
  }
}
