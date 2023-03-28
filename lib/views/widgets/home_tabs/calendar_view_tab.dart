import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo_assessment/gen/colors.gen.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';

// model need to have appointment

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
    // TODO: navigate to task view
    log('CalendarTapDetails: ${calendarTapDetails.appointments}');
    if (_calendarController.view == CalendarView.month) {
      _calendarController.view = CalendarView.schedule;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = [
      Appointment(
        subject: 'Watering plants',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        id: 'sumimasen',
      ),
      Appointment(
        subject: 'Eating oranges',
        color: Colors.black,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        id: 'rasengan',
      ),
    ];

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
        color: Colors.orange,
        borderRadius: isMonth ? null : BorderRadius.circular(5.0),
      ),
      child: Text(
        appointment.subject,
        maxLines: isMonth ? 1 : null,
        style: const TextStyle(
          color: Colors.white,
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
  final List<Appointment> appointments;

  DataTesting({
    required this.appointments,
  });
}
