import 'package:event_reminder_app/core/components/widgets/svg_widget.dart';
import 'package:event_reminder_app/core/components/widgets/tag_chosechips.dart';
import 'package:event_reminder_app/core/components/widgets/title_widget.dart';
import 'package:event_reminder_app/core/constants/project_variables.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/core/extension/string_extension.dart';
import 'package:event_reminder_app/core/init/utils/widgets/custom_refreshindicator_widget.dart';
import 'package:event_reminder_app/core/init/utils/widgets/safe_listview_widget.dart';
import 'package:event_reminder_app/features/home/events_page/event_provider.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

@immutable
final class EventView extends ConsumerStatefulWidget {
  const EventView({super.key});

  @override
  ConsumerState<EventView> createState() => _EventViewState();
}

class _EventViewState extends ConsumerState<EventView> {
  late EventState eventProviderListener;
  late EventProvider eventProviderNoListener;
  final eventProvider = StateNotifierProvider<EventProvider, EventState>(
    (ref) => EventProvider(),
  );

  @override
  Widget build(BuildContext context) {
    eventProviderListener = ref.watch(eventProvider);
    eventProviderNoListener = ref.read(eventProvider.notifier);
    return RefreshIndicatorSafe(
      isScrollable: eventProviderListener.notes?.isNotEmpty ?? false,
      onRefresh: () async {
        await eventProviderNoListener.getDataFromFirebase();
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: context.paddingScaffold,
            child: _bodyColumn(),
          ),
        ),
      ),
    );
  }

  Widget _bodyColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(context.dynamicHeight(0.05)),
        const TitleView(text: StringConstants.eventForToday),
        Expanded(
          child: Center(
            child: SafeListView(
              noDataWidget: noDataWidget,
              itemCount: eventProviderListener.notes?.length,
              itemBuilder: (p0, index) {
                final item = eventProviderListener.notes![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleDateAvatar(
                            item: item,
                          ),
                          Gap(context.dynamicHeight(0.015)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeText(item),
                                titleText(item),
                                chips(item)
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Wrap chips(Note item) {
    return Wrap(
      spacing: 4,
      runSpacing: -7,
      children: List.generate(
        item.tagsId?.length ?? 0,
        (index) {
          final tag = eventProviderNoListener.getTagDetail(item.tagsId![index]);
          return Chip(
            backgroundColor: tag.color,
            shape: RoundedRectangleBorder(
              borderRadius: context.borderRadiusHigh,
            ),
            label: Text(
              tag.title.toString(),
              style: context.textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Text titleText(Note item) {
    return Text(
      item.title!,
      style: context.textTheme.titleLarge,
    );
  }

  Text timeText(Note item) {
    return Text(
      '${item.startDate!.hour}:${item.startDate!.minute} - ${item.endDate!.hour}:${item.endDate!.minute}',
      style:
          context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget get noDataWidget => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPath.noData
                .toWidget(context: context, size: context.dynamicHeight(0.25)),
            Gap(context.dynamicHeight(0.015)),
            Text(
              StringConstants.dontHaveANote,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.red.shade300,
              ),
            )
          ],
        ),
      );
}

class CircleDateAvatar extends StatelessWidget {
  const CircleDateAvatar({
    required this.item,
    super.key,
  });
  final Note item;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade400,
      radius: ProjectVaribles.circleAvatarHigh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.startDate!.day.toString(),
            style: context.textTheme.titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            item.startDate!.toString().dateTimeMMM!.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
