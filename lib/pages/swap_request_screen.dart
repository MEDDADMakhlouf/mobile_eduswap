import 'package:flutter/material.dart';

// THIS IS THE CORRECT LOCATION FOR THE SwapRequest CLASS
// It must be at the very top level of the file, outside of any other class.
class SwapRequest {
  final String date;
  final String subject;
  final String professor;
  final String type;
  final String room;
  final String newRoom; // Could be 'N/A' if type is 'Clear'
  final String status;

  SwapRequest({
    required this.date,
    required this.subject,
    required this.professor,
    required this.type,
    required this.room,
    required this.newRoom,
    required this.status,
  });
}

class SwapRequestScreen extends StatefulWidget {
  const SwapRequestScreen({super.key});

  @override
  State<SwapRequestScreen> createState() => _SwapRequestScreenState();
}

class _SwapRequestScreenState extends State<SwapRequestScreen> {
  // Simulate fetching swap request data from a database/API
  Future<List<SwapRequest>> _fetchSwapRequests() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Dummy data mimicking your image, now using the SwapRequest class
    return [
      SwapRequest(
        date: 'March 20, 2025',
        subject: 'Database Systems',
        professor: 'Zeghedani Salah eddine',
        type: 'Clear',
        room: '214D',
        newRoom: 'N/A', // Use N/A for clear requests
        status: 'Accepted',
      ),
      SwapRequest(
        date: 'March 20, 2024',
        subject: 'Algorithms',
        professor: 'Karim Benali',
        type: 'Swap', // Example of a 'Swap' type
        room: 'B-101',
        newRoom: 'C-202',
        status: 'Pending',
      ),
      SwapRequest(
        date: 'March 20, 2025',
        subject: 'Linear Algebra',
        professor: 'Amine Djeradi',
        type: 'Clear',
        room: 'A-302',
        newRoom: 'N/A',
        status: 'Rejected',
      ),
      SwapRequest(
        date: 'March 21, 2025',
        subject: 'Software Engineering',
        professor: 'Selma Bouzid',
        type: 'Clear',
        room: 'D-102',
        newRoom: 'N/A',
        status: 'Accepted',
      ),
      SwapRequest(
        date: 'March 21, 2025',
        subject: 'Operating Systems',
        professor: 'Reda Hamdi',
        type: 'Swap',
        room: 'E-401',
        newRoom: 'F-505',
        status: 'Pending',
      ),
      SwapRequest(
        date: 'March 22, 2025',
        subject: 'Computer Networks',
        professor: 'Naila Hoacine',
        type: 'Clear',
        room: 'G-110',
        newRoom: 'N/A',
        status: 'Rejected',
      ),
      SwapRequest(
        date: 'March 22, 2025',
        subject: 'Web Development',
        professor: 'Lyes Cherif',
        type: 'Clear',
        room: 'H-201',
        newRoom: 'N/A',
        status: 'Pending',
      ),
      SwapRequest(
        date: 'March 23, 2025',
        subject: 'Machine Learning',
        professor: 'Sara Mansouri',
        type: 'Swap',
        room: 'I-303',
        newRoom: 'J-404',
        status: 'Accepted',
      ),
      SwapRequest(
        date: 'March 23, 2025',
        subject: 'Artificial Intelligence',
        professor: 'Fouad Djebbar',
        type: 'Clear',
        room: 'K-500',
        newRoom: 'N/A',
        status: 'Pending',
      ),
      SwapRequest(
        date: 'March 24, 2025',
        subject: 'Data Structures',
        professor: 'Imane Gherbi',
        type: 'Clear',
        room: 'L-101',
        newRoom: 'N/A',
        status: 'Rejected',
      ),
    ];
  }

  // Helper to get color for status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green.shade100;
      case 'pending':
        return Colors.orange.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  // Helper to get text color for status
  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green.shade800;
      case 'pending':
        return Colors.orange.shade800;
      case 'rejected':
        return Colors.red.shade800;
      default:
        return Colors.grey.shade800;
    }
  }

  // Helper to get color for type
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'clear':
        return Colors.blue.shade100;
      case 'swap':
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  // Helper to get text color for type
  Color _getTypeTextColor(String type) {
    switch (type.toLowerCase()) {
      case 'clear':
        return Colors.blue.shade700;
      case 'swap':
        return Colors.purple.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'TimeSwap',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Text('NH', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Swap Request',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Request. View and search your past swap requests',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Search and Filter Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by subject, teacher, or date...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'All Types', // Default value
                        items: <String>['All Types', 'Clear', 'Swap']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // TODO: Implement filtering logic
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'All Statuses', // Default value
                        items: <String>['All Statuses', 'Accepted', 'Pending', 'Rejected']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // TODO: Implement filtering logic
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Swap Request button press
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Swap Request', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Custom Table UI using ListView.builder and Cards
            Expanded(
              child: FutureBuilder<List<SwapRequest>>(
                future: _fetchSwapRequests(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No swap requests available.'));
                  } else {
                    final swapRequests = snapshot.data!;

                    return ListView.builder(
                      itemCount: swapRequests.length,
                      itemBuilder: (context, index) {
                        final request = swapRequests[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      request.date,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(request.status),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        request.status,
                                        style: TextStyle(
                                          color: _getStatusTextColor(request.status),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  request.subject,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Prof. ${request.professor}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.meeting_room, color: Colors.grey[600], size: 18),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Room: ${request.room}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                    ),
                                    const SizedBox(width: 15),
                                    // Only show "New Room" if it's a 'Swap' type and not 'N/A'
                                    if (request.type.toLowerCase() == 'swap' && request.newRoom != 'N/A')
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_right_alt, color: Colors.grey[600], size: 18),
                                          const SizedBox(width: 5),
                                          Text(
                                            'New Room: ${request.newRoom}',
                                            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(request.type),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      request.type,
                                      style: TextStyle(
                                        color: _getTypeTextColor(request.type),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            // Pagination (simplified)
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Page 1 of 10'),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}