import 'package:flutter/material.dart';

class RefreshIndicatorSafe extends StatelessWidget {
  const RefreshIndicatorSafe({
    required this.onRefresh,
    required this.isScrollable,
    required this.child,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final bool isScrollable;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: isScrollable
          ? child
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(child: child),
                ),
              ),
            ),
    );
  }
}
