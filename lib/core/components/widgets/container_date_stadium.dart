import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StadiumContainerDate extends StatelessWidget {
  const StadiumContainerDate({
    required this.text,
    this.isEnable,
    this.onTap,
    super.key,
  });
  final String text;
  final void Function()? onTap;
  final bool? isEnable;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isEnable ?? false,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.grey.shade300,
            shape: const StadiumBorder(),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Gap(context.dynamicWidth(0.003)),
                  Text(
                    text,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: (isEnable ?? false) ? Colors.grey : Colors.black54,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: (isEnable ?? false) ? Colors.grey : Colors.black54,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
