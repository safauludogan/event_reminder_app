import 'package:event_reminder_app/core/components/widgets/base_appbar.dart';
import 'package:event_reminder_app/core/components/widgets/sf_calender.dart';
import 'package:event_reminder_app/core/components/widgets/title_widget.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/features/home/event_detail/event_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailView extends ConsumerStatefulWidget {
  const EventDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventDetailViewState();
}

class _EventDetailViewState extends ConsumerState<EventDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventDetailProviderNoListener.disp();
    });
  }

  late EventDetailState eventDetailProviderListener;
  late EventDetailProvider eventDetailProviderNoListener;
  final eventProvider =
      StateNotifierProvider<EventDetailProvider, EventDetailState>(
    (ref) => EventDetailProvider(),
  );

  @override
  Widget build(BuildContext context) {
    eventDetailProviderListener = ref.watch(eventProvider);
    eventDetailProviderNoListener = ref.read(eventProvider.notifier);
    if (eventDetailProviderListener.isLoading != null &&
        eventDetailProviderListener.isLoading!) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: BaseAppBar(title: StringConstants.eventDetail),
        body: SafeArea(
          child: CustomSfCalendar(
            calendarController:
                eventDetailProviderNoListener.calendarController,
            dataSource: eventDetailProviderNoListener.calendarDataSource,
          ),
        ),
      );
    }
  }
}
