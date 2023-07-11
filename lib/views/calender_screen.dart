import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<String, String> gymEvents = {
    "Mon": "Beckton",
    "Tue": "",
    "Wed": "",
    "Thu": "Beckton",
    "Fri": "Beckton",
    "Sat": "Stratford",
    "Sun": "",
  };

  Map<String, String> timeSlots = {
    "Mon": "5:00 PM - 9:00 PM",
    "Tue": "",
    "Wed": "",
    "Thu": "5:00 PM - 8:00 PM",
    "Fri": "5:00 PM - 9:00 PM",
    "Sat": "10:00 AM - 3:00 PM",
    "Sun": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: orangeColor,
          title: Center(
            child: Text('Calendar'),
          )),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 105, 223),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.fitness_center),
                  title: Text("Event/Timing"),
                  subtitle: _buildEventSubtitle(),
                  trailing: Icon(Icons.event),
                  onTap: () {
                    // Handle item tap
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventSubtitle() {
    String selectedDay = _getSelectedWeekday();
    String timeSlot = timeSlots[selectedDay]!;
    String gymEvent = gymEvents[selectedDay]!;

    if (timeSlot.isNotEmpty && gymEvent.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time: $timeSlot"),
          Text("Gym Event: $gymEvent"),
        ],
      );
    } else {
      return Text("No time slot or gym event available");
    }
  }

  String _getSelectedWeekday() {
    List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    int selectedDayIndex = (_selectedDay.weekday - 1) % 7;
    return weekdays[selectedDayIndex];
  }

  String _getGymEvent(int index) {
    String selectedDay = _getSelectedWeekday();
    String gymEvent = gymEvents[selectedDay]!;

    if (gymEvent.isNotEmpty) {
      return gymEvent;
    } else {
      return gymEvents.values.elementAt(index);
    }
  }
}
