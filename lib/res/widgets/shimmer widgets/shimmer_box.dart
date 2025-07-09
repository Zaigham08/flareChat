import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double height, width, radius;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.margin,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withValues(alpha: .4),
      highlightColor: Colors.grey.withValues(alpha: .6),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white,
        ),
      ),
    );
  }
}
