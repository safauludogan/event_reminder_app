import 'package:event_reminder_app/core/components/widgets/base_appbar.dart';
import 'package:event_reminder_app/core/components/widgets/container_date_stadium.dart';
import 'package:event_reminder_app/core/components/widgets/custom_switch.dart';
import 'package:event_reminder_app/core/components/widgets/custom_textformfield.dart';
import 'package:event_reminder_app/core/components/widgets/tag_chosechips.dart';
import 'package:event_reminder_app/core/components/widgets/title_widget.dart';
import 'package:event_reminder_app/core/constants/project_variables.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/constants/validators.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/core/extension/string_extension.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/core/utils/chips_shimmer.dart';
import 'package:event_reminder_app/features/home/create_event/create_event_provider.dart';
import 'package:event_reminder_app/features/home/create_event/create_event_state.dart';
import 'package:event_reminder_app/product/utility/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

part 'components/event_date_selection_base.dart';

@immutable
final class CreateEventView extends ConsumerStatefulWidget {
  const CreateEventView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateEventViewState();
}

class _CreateEventViewState extends ConsumerState<CreateEventView> {
  @override
  void dispose() {
    super.dispose();
    createNoteProviderNoListener.disp();
  }

  late CreateNoteState createNoteProviderListener;
  late CreateNoteProvider createNoteProviderNoListener;
  final createNoteProvider =
      StateNotifierProvider<CreateNoteProvider, CreateNoteState>(
    (ref) => CreateNoteProvider(),
  );

  @override
  Widget build(BuildContext context) {
    createNoteProviderListener = ref.watch(createNoteProvider);
    createNoteProviderNoListener = ref.read(createNoteProvider.notifier);
    return _baseBody(context);
  }

  Scaffold _baseBody(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: StringConstants.newEvent),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.paddingScaffold,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: createNoteProviderNoListener.globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(context.dynamicHeight(0.02)),
                titleTextField(),
                Gap(context.dynamicHeight(0.01)),
                locationTextField(),
                Gap(context.dynamicHeight(0.01)),
                eventDateSelection(),
                Gap(context.dynamicHeight(0.01)),
                tags(),
                Gap(context.dynamicHeight(0.02)),
                noteTextField(),
                Gap(context.dynamicHeight(0.02)),
                createButton(),
                Gap(context.dynamicHeight(0.03)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => createNoteProviderNoListener.postDataToFirebase(),
        icon: const Icon(
          Icons.create,
          size: 18,
        ),
        label: Text(
          StringConstants.create,
          style: context.textTheme.labelLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Column noteTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText('${StringConstants.notes}:'),
        Gap(context.dynamicHeight(0.01)),
        CustomTextFormField(
          maxLines: ProjectVaribles.noteTextMaxLine,
          controller: createNoteProviderNoListener.noteController,
          hintText: '',
          maxLength: ProjectVaribles.noteMaxLength,
          validator: validateNote,
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }

  Widget tags() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: headerText('${StringConstants.tags}:'),
        ),
        Wrap(
          spacing: 4,
          runSpacing: -7,
          children: createNoteProviderListener.tagsLoading
              ? List.generate(8, (index) => const ChipsShimmer()).toList()
              : List.generate(
                  createNoteProviderListener.tags?.length ?? 0,
                  tagList,
                ).toList(),
        )
      ],
    );
  }

  TagChoseChips tagList(int index) {
    return TagChoseChips(
      isSelected: createNoteProviderListener.chipValues![index],
      labelString: createNoteProviderListener.tags![index].title!,
      selectedColor: createNoteProviderListener.tags![index].color,
      onSelected: (selected) {
        createNoteProviderNoListener.updateChipValue(
          index,
          selected,
        );
      },
    );
  }

  Widget eventDateSelection() {
    return Column(
      children: [
        switchText(
          StringConstants.allDayEvent,
          createNoteProviderNoListener.changeAllDayEventSelect,
          value: createNoteProviderListener.isAllDayEventSelect,
        ),
        EventSelectionBase(
          isStartDate: true,
          isEnable: createNoteProviderListener.isAllDayEventSelect,
          onDateSelect: (date) {
            ref.read(createNoteProvider.notifier).setStartDate(date);
          },
          onTimeSelect: (time) {
            ref.read(createNoteProvider.notifier).setStartTime(time);
          },
          subTitle: StringConstants.start,
          date: createNoteProviderListener.startDate
              .toString()
              .dateFormat
              .toString(),
          time: createNoteProviderListener.startTime ??
              TimeOfDay.now().format(context),
        ),
        Gap(context.dynamicHeight(0.01)),
        EventSelectionBase(
          isEnable: createNoteProviderListener.isAllDayEventSelect,
          onDateSelect: (date) {
            ref.read(createNoteProvider.notifier).setEndDate(date);
          },
          onTimeSelect: (time) {
            ref.read(createNoteProvider.notifier).setEndTime(time);
          },
          subTitle: StringConstants.end,
          date: createNoteProviderListener.endDate
              .toString()
              .dateFormat
              .toString(),
          time: createNoteProviderListener.endTime ??
              TimeOfDay.now().format(context),
        ),
        Gap(context.dynamicHeight(0.004)),
        switchText(
          StringConstants.repetitiveEvent,
          createNoteProviderNoListener.changeRepetitiveEventSelect,
          value: createNoteProviderListener.isRepetitiveEventSelect,
        ),
      ],
    );
  }

  Widget locationTextField() {
    return CustomTextFormField(
      controller: createNoteProviderNoListener.locationController,
      hintText: StringConstants.locationOrMeetingUrl,
      maxLength: ProjectVaribles.textLocationMaxLength,
      validator: validateLocation,
    );
  }

  Widget titleTextField() {
    return CustomTextFormField(
      controller: createNoteProviderNoListener.titleController,
      hintText: StringConstants.title,
      validator: validateTitle,
    );
  }

  Widget switchText(
    String title,
    void Function(bool) onChange, {
    required bool value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerText(title),
        CustomSwitch(
          value: value,
          onChanged: onChange,
        ),
      ],
    );
  }

  Widget headerText(String text) => Text(
        text,
        style:
            context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      );
}
