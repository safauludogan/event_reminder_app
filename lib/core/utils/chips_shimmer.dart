import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChipsShimmer extends StatelessWidget {
  const ChipsShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ChoiceChip(
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: SizedBox.shrink(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: context.borderRadiusHigh,
        ),
        selected: false,
      ),
    );
  }
}
