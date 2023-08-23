import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.text,
    required this.callback,
    super.key,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback callback;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading != null && isLoading!) ? null : callback,
      child: SizedBox(
        height: kIsWeb == true
            ? context.dynamicHeight(0.98)
            : context.dynamicHeight(0.065),
        child: Center(
          child: (isLoading != null && isLoading!)
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: context.textTheme.labelLarge!
                      .copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
