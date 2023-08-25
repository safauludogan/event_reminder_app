part of '../create_event_view.dart';

class EventSelectionBase extends StatelessWidget {
  const EventSelectionBase({
    required this.subTitle,
    required this.date,
    required this.time,
    this.onDateSelect,
    this.onTimeSelect,
    this.isEnable,
    this.isStartDate,
    super.key,
  });
  final String subTitle;
  final String date;
  final String time;
  final bool? isEnable;
  final bool? isStartDate;
  final void Function(DateTime)? onDateSelect;
  final void Function(String)? onTimeSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        subTitleText(subTitle),
        const Spacer(),
        StadiumContainerDate(
          isEnable: !(isStartDate ?? false) && (isEnable ?? false),
          text: date,
          onTap: () async {
            final selectedDate = await DatePicker().pickDate(context: context);
            if (selectedDate == null) return;
            onDateSelect?.call(selectedDate);
          },
        ),
        const Gap(5),
        StadiumContainerDate(
          isEnable: isEnable,
          text: time,
          onTap: () async {
            final selectedTime = await DatePicker().pickTime(context: context);
            if (selectedTime == null) return;
            onTimeSelect?.call(selectedTime);
          },
        ),
      ],
    );
  }

  Widget subTitleText(String text) => Text(
        text,
        style: context.textTheme.labelMedium,
      );
}
