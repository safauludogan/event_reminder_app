import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StadiumContainerDate extends StatelessWidget {
  const StadiumContainerDate({required this.text, this.onTap, super.key});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 22,
        decoration: ShapeDecoration(
          color: Colors.grey.shade300,
          shape: const StadiumBorder(),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Gap(context.dynamicWidth(0.003)),
              Text(
                text,
                style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
