import 'package:flutter/material.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/core/init/utils/network/network_change_manager.dart';
import '../../constants/string_constants.dart';
import '../network/viewmodel/no_network_viewmodel.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends NoNetworkViewModel {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: Column(
          children: [
            const LinearProgressIndicator(
              backgroundColor: Colors.red,
              color: Colors.white,
            ),
            Center(
              child: Padding(
                padding: context.paddingLow,
                child: Text(
                  StringConstants.noInternetConnection,
                  style: context.textTheme.labelMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        secondChild: const SizedBox.shrink(),
        crossFadeState: networkResult == NetworkResult.off
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: context.lowDuration);
  }
}
