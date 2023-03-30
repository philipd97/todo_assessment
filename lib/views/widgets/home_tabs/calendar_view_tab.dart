import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/gen/colors.gen.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/pages/task_entry_page.dart';

class CalendarViewTab extends StatefulWidget {
  const CalendarViewTab({super.key});

  @override
  State<CalendarViewTab> createState() => _CalendarViewTabState();
}

class _CalendarViewTabState extends State<CalendarViewTab> {
  final _calendarController = CalendarController();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_calendarController.view == CalendarView.month) {
      if (calendarTapDetails.targetElement == CalendarElement.header) return;
      if (calendarTapDetails.appointments!.isEmpty) {
        context.push(TaskEntryPage.routeName, extra: {
          'task': Task(
            date: calendarTapDetails.date!,
          ),
        });
      } else {
        _calendarController.view = CalendarView.schedule;
      }
      return;
    } else {
      if (calendarTapDetails.appointments == null) return;
      final appointmentId =
          (calendarTapDetails.appointments!.first as Appointment).id;
      final task = context
          .read<TaskBloc>()
          .state
          .tasks
          .firstWhere((element) => element.id == appointmentId);
      context.push(TaskDetailPage.routeName, extra: {'task': task});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final appointments = state.tasks
            .map(
              (task) => Appointment(
                id: task.id,
                subject: task.title!,
                startTime: task.date,
                endTime: task.date,
                color: task.scheduleEnum.tileColor,
              ),
            )
            .toList();
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SfCalendar(
            controller: _calendarController,
            view: CalendarView.month,
            showDatePickerButton: true,
            dataSource: DataTesting(appointments: appointments),
            allowedViews: const [CalendarView.month, CalendarView.schedule],
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            todayHighlightColor: ColorName.todayCompletedText,
            todayTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            appointmentBuilder: (_, calendarAppointmentDetails) =>
                _AppointmentBuilder(
              calendarAppointmentDetails: calendarAppointmentDetails,
              isMonth: _calendarController.view == CalendarView.month,
            ),
            scheduleViewMonthHeaderBuilder: (_, details) =>
                _ScheduleMonthHeader(details: details),
            onTap: _onCalendarTapped,
          ),
        );
      },
    );
  }
}

class _AppointmentBuilder extends StatelessWidget {
  final CalendarAppointmentDetails calendarAppointmentDetails;
  final bool isMonth;

  const _AppointmentBuilder({
    super.key,
    required this.calendarAppointmentDetails,
    required this.isMonth,
  });

  @override
  Widget build(BuildContext context) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return Container(
      height: calendarAppointmentDetails.bounds.height,
      width: calendarAppointmentDetails.bounds.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appointment.color,
        borderRadius: isMonth ? null : BorderRadius.circular(5.0),
      ),
      child: Text(
        appointment.subject,
        maxLines: isMonth ? 1 : null,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ScheduleMonthHeader extends StatelessWidget {
  final ScheduleViewMonthHeaderDetails details;

  const _ScheduleMonthHeader({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final path = CalendarMonthEnum.values[details.date.month - 1].imgPath;
    final monthName = DateFormat.MMMM().format(details.date);
    return Stack(
      children: [
        Image(
          image: ExactAssetImage(path),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height,
        ),
        Positioned(
          left: 55,
          right: 0,
          top: 20,
          bottom: 0,
          child: Text(
            '$monthName ${details.date.year}',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.75,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey[800]!,
            ),
          ),
        )
      ],
    );
  }
}

class DataTesting extends CalendarDataSource {
  @override
  final List<Appointment> appointments;

  DataTesting({
    required this.appointments,
  });
}
