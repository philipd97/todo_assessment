import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo_assessment/gen/colors.gen.dart';

// model need to have appointment

class CalendarViewTab extends StatelessWidget {
  const CalendarViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = [
      Appointment(
        subject: 'Watering plants',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
      )
    ];

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SfCalendar(
        view: CalendarView.month,
        showDatePickerButton: true,
        dataSource: DataTesting(appointments: appointments),
        allowedViews: const [CalendarView.month, CalendarView.schedule],
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        todayHighlightColor: ColorName.todayCompletedText,
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Appointment appointment =
              calendarAppointmentDetails.appointments.first;
          // TODO: check calendar month view then render diff widget
          return Container(
            height: calendarAppointmentDetails.bounds.height,
            width: calendarAppointmentDetails.bounds.width,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              appointment.subject,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        scheduleViewSettings: ScheduleViewSettings(
          appointmentTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          weekHeaderSettings: WeekHeaderSettings(),
          monthHeaderSettings: MonthHeaderSettings(),
        ),
        onTap: (calendarTapDetails) {
          log('CalendarTapDetails: ${calendarTapDetails.date}, ${calendarTapDetails.resource}, ${calendarTapDetails.appointments}, ${calendarTapDetails.targetElement}');
        },
      ),
    );
  }
}

class DataTesting extends CalendarDataSource {
  final List<Appointment> appointments;

  DataTesting({
    required this.appointments,
  });
}
