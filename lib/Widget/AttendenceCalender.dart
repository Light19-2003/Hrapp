import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrapp/Model/AttendenceRecords.dart';

class AttendanceCalendar extends StatelessWidget {
  final List<AttendanceRecord> records;
  final DateTime month;

  const AttendanceCalendar({
    super.key,
    required this.records,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    // Group records by week
    final weeks = <int, List<AttendanceRecord>>{};
    for (var record in records) {
      weeks.putIfAbsent(record.weekNumber!, () => []).add(record);
    }

    return Column(
      children: [
        // Weekday headers
        _buildWeekdayHeaders(),
        const SizedBox(height: 8),
        // Calendar weeks
        ..._buildCalendarWeeks(weeks),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    return Row(
      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
          .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  List<Widget> _buildCalendarWeeks(Map<int, List<AttendanceRecord>> weeks) {
    return weeks.values.map((weekRecords) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: List.generate(7, (index) {
            final dayRecord = weekRecords.firstWhere(
              (r) => r.wkOrder == index + 1,
              orElse: () => AttendanceRecord(
                atnDateDay: 0,
                attnD: '',
                atnDay: '',
                weekNumber: 0,
                wkOrder: index + 1,
                sMonth: '',
              ),
            );

            return Expanded(
              child: dayRecord.atnDateDay != 0
                  ? _buildDayCell(dayRecord)
                  : Container(),
            );
          }),
        ),
      );
    }).toList();
  }

  Widget _buildDayCell(AttendanceRecord record) {
    final statusColor = _getStatusColor(record.attnD!);

    return Column(
      children: [
        Container(
          height: 47.h,
          width: 47.w,
          decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300)),
          child: Center(
            child: Text(
              record.atnDateDay.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Text(
        //   _getStatusAbbreviation(record.attnD!),
        //   style: TextStyle(
        //     fontSize: 10,
        //     color: statusColor,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'P':
        return Colors.green;
      case 'A':
        return Colors.red;
      case 'WK':
      case 'WE':
        return Colors.grey;
      case 'H':
        return Colors.orange;
      case 'L':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  String _getStatusAbbreviation(String status) {
    switch (status.toUpperCase()) {
      case 'P':
        return 'P';
      case 'A':
        return 'A';
      case 'WK':
      case 'WE':
        return 'W';
      case 'H':
        return 'H';
      case 'L':
        return 'L';
      default:
        return '';
    }
  }
}
