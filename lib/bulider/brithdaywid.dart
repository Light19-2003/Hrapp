import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/controller/Profilecontroller.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart'; // Add this import

class BirthdayWidget extends StatelessWidget {
  const BirthdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Dashboardcontroller());

    final today = DateTime.now();

    return Obx(() {
      if (controller.brithdayslist.isEmpty) {
        return _buildEmptyState();
      }

      return Container(
        height: 160, // Increased height for better spacing
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.brithdayslist.length,
          itemBuilder: (context, index) {
            final emp = controller.brithdayslist[index];
            debugPrint("emp ${emp.userimage}");

            final dateTime = DateTime.parse(emp.dob.toString());
            final isToday =
                dateTime.month == today.month && dateTime.day == today.day;
            final formattedDate = DateFormat('d MMM').format(dateTime);
            final name = _getFormattedName(emp.empname);

            return _BirthdayCard(
              name: name,
              date: formattedDate,
              imageBytes: emp.imageBytes,
              userimage: emp.userimage,
              isToday: isToday,
              age: _calculateAge(dateTime),
            );
          },
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        height: 160,
        alignment: Alignment.center,
        child: Text(
          "No upcoming birthdays",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _getFormattedName(String? fullName) {
    if (fullName == null) return "Employee";
    final nameParts = fullName.split(' ');
    return nameParts.length > 1
        ? '${nameParts[0]} ${nameParts[1][0]}.'
        : fullName;
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}

class _BirthdayCard extends StatefulWidget {
  final String name;
  final String date;
  final Uint8List? imageBytes;
  final bool isToday;
  final String? userimage;
  final int age;

  const _BirthdayCard({
    required this.name,
    required this.date,
    this.imageBytes,
    this.isToday = false,
    required this.age,
    this.userimage,
  });

  @override
  State<_BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<_BirthdayCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    if (widget.isToday) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Confetti effect for today's birthday
          if (widget.isToday)
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 15,
              gravity: 0.1,
            ),

          // Birthday card content
          ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar with decoration
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade200,
                        Colors.pink.shade200,
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          "http://hrdemo.rs-apps.online/EmployeeDocument/${widget.userimage}")),
                ),

                // Name and age
                Column(
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   '${widget.age} yrs',
                    //   style: TextStyle(
                    //     fontSize: 10,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),`
                  ],
                ),

                // Date with highlight

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.isToday
                        ? Colors.red.shade50
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.isToday ? Colors.red : Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Celebration icon for today
                if (widget.isToday)
                  const Icon(
                    Icons.celebration,
                    color: Colors.amber,
                    size: 20,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
