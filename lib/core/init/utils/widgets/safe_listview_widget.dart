import 'package:animate_do/animate_do.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SafeListView extends StatelessWidget {
  const SafeListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.noDataWidget,
    super.key,
    this.description,
  });
  final int? itemCount;
  final Widget? Function(BuildContext, int index) itemBuilder;
  final Widget noDataWidget;
  final String? description;
  @override
  Widget build(BuildContext context) {
    if (itemCount == null || itemCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: noDataWidget),
            if (description != null)
              const SizedBox(height: 40)
            else
              const SizedBox.shrink(),
            if (description != null)
              Text(
                description!,
                style:
                    context.textTheme.titleMedium!.copyWith(color: Colors.grey),
              )
            else
              const SizedBox.shrink()
          ],
        ),
      );
    }
    return FadeInUp(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
