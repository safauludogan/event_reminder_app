import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomSfCalendar extends StatelessWidget {
  const CustomSfCalendar(
      {required this.calendarController,
      required this.dataSource,
      this.onViewChanged,
      super.key});
  final CalendarController? calendarController;
  final CalendarDataSource? dataSource;
  final void Function(ViewChangedDetails)? onViewChanged;
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      controller: calendarController,
      onViewChanged: onViewChanged,
      view: CalendarView.month,
      dataSource: dataSource,
      allowViewNavigation: true,
      showDatePickerButton: true,
      showTodayButton: true,
      showNavigationArrow: true,
      loadMoreWidgetBuilder:
          (BuildContext context, LoadMoreCallback loadMoreAppointments) {
        return FutureBuilder(
          future: loadMoreAppointments(),
          builder: (context, snapShot) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white38,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          },
        );
      },
      appointmentTextStyle: context.textTheme.titleSmall!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      //headerHeight: 0,
      viewHeaderStyle: ViewHeaderStyle(
        dateTextStyle: context.textTheme.labelSmall!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: context.textTheme.labelSmall!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      cellBorderColor: Colors.transparent,

      monthViewSettings: MonthViewSettings(
        showAgenda: true,
        //showTrailingAndLeadingDates: false,
        monthCellStyle: MonthCellStyle(
          textStyle: context.textTheme.labelLarge,
          trailingDatesTextStyle:
              context.textTheme.labelLarge!.copyWith(color: Colors.grey),
        ),
        dayFormat: 'EEE',
      ),
    );
  }
}
