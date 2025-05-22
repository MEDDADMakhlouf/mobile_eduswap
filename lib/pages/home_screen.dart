import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulate fetching data from a database
  Future<List<Map<String, String>>> _fetchTimetableData() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1)); // Reduced delay for quicker testing

    // This is dummy data. In a real app, you'd fetch this from your database.
    return [
      {
        'Time': '08:00 - 09:30',
        'Subject': 'Computer Science 101',
        'Room': 'B-101',
        'Professor': 'Prof. Naila Hoacine',
        'Day': 'Monday',
        'Color': 'blue', // Custom field for color
      },
      {
        'Time': '09:45 - 11:15',
        'Subject': 'Algorithms',
        'Room': 'C-203',
        'Professor': 'Prof. Karim Benali',
        'Day': 'Tuesday',
        'Color': 'green',
      },
      {
        'Time': '11:30 - 13:00',
        'Subject': 'Programming Languages',
        'Room': 'A-302',
        'Professor': 'Prof. Amine Djeradi',
        'Day': 'Thursday',
        'Color': 'purple',
      },
      {
        'Time': '13:30 - 15:00',
        'Subject': 'Database Systems',
        'Room': 'D-102',
        'Professor': 'Prof. Selma Bouzid',
        'Day': 'Monday',
        'Color': 'orange',
      },
      {
        'Time': '15:15 - 16:45',
        'Subject': 'Final Exams - Mathematics',
        'Room': 'Main Hall',
        'Professor': 'Prof. Reda Hamdi',
        'Day': 'Wednesday',
        'Color': 'red',
      },
      // Add more data for other days or available slots if needed
      {
        'Time': '10:00 - 11:00',
        'Subject': 'Available',
        'Room': '',
        'Professor': '',
        'Day': 'Wednesday',
        'Color': 'grey',
      },
    ];
  }

  // Helper function to get color from string
  Color _getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue.shade200;
      case 'green':
        return Colors.green.shade200;
      case 'purple':
        return Colors.purple.shade200;
      case 'orange':
        return Colors.orange.shade200;
      case 'red':
        return Colors.red.shade200;
      case 'grey':
        return Colors.grey.shade300;
      default:
        return Colors.blueGrey.shade100; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Added space for status bar/app bar
            const Text(
              'Hello!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Here’s your workspace.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Your Timetable',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: _fetchTimetableData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No timetable data available.'));
                  } else {
                    final timetableData = snapshot.data!;
                    // Group by day for a better vertical display
                    final Map<String, List<Map<String, String>>> groupedByDay = {};
                    for (var entry in timetableData) {
                      final day = entry['Day']!;
                      if (!groupedByDay.containsKey(day)) {
                        groupedByDay[day] = [];
                      }
                      groupedByDay[day]!.add(entry);
                    }

                    // Define order of days
                    final List<String> orderedDays = [
                      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
                    ];

                    return ListView.builder(
                      itemCount: orderedDays.length,
                      itemBuilder: (context, index) {
                        final day = orderedDays[index];
                        final entriesForDay = groupedByDay[day];

                        if (entriesForDay == null || entriesForDay.isEmpty) {
                          return const SizedBox.shrink(); // Hide if no entries for the day
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true, // Important for nested ListView
                              physics: const NeverScrollableScrollPhysics(), // Disable scrolling for inner list
                              itemCount: entriesForDay.length,
                              itemBuilder: (context, entryIndex) {
                                final entry = entriesForDay[entryIndex];
                                final time = entry['Time'] ?? 'N/A';
                                final subject = entry['Subject'] ?? 'N/A';
                                final room = entry['Room'] ?? '';
                                final professor = entry['Professor'] ?? '';
                                final color = _getColor(entry['Color'] ?? 'grey');

                                // Render 'Available' slots differently
                                if (subject == 'Available') {
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    color: color,
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.check_circle_outline, color: Colors.black54),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                time,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                subject,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800],
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  color: color,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          time,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          subject,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        if (room.isNotEmpty)
                                          Text(
                                            'Room: $room',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        if (professor.isNotEmpty)
                                          Text(
                                            'Prof: $professor',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20), // Space between days
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}