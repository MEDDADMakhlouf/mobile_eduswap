import 'package:flutter/material.dart';

// Data model for a notification (similar to SwapRequest for consistency)
class NotificationItem {
  final String type; // e.g., 'New Swap Request', 'Swap Request Accepted', 'Swap Request Rejected', 'Schedule Change'
  final String title;
  final String message;
  final String timeAgo;
  final String? status; // 'Accepted', 'Declined' for new swap requests, or null
  final String? roomChange; // For 'Schedule Change'
  final String? newRoom; // For 'Schedule Change'

  NotificationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.status,
    this.roomChange,
    this.newRoom,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<NotificationItem>> _notificationsFuture;

  // Simulate fetching notifications
  Future<List<NotificationItem>> _fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      NotificationItem(
        type: 'New Swap Request',
        title: 'New Swap Request',
        message: 'Prof. Naila Hoacine has requested to swap Physics 202 on March 25, 2025 for Computer Networks.',
        timeAgo: '10 minutes ago',
      ),
      NotificationItem(
        type: 'Swap Request Accepted',
        title: 'Swap Request Accepted',
        message: 'Prof. Naila Hoacine has accepted your swap request for Mathematics 101 on March 25, 2025.',
        timeAgo: '10 minutes ago',
      ),
      NotificationItem(
        type: 'Swap Request Rejected',
        title: 'Swap Request Rejected',
        message: 'Prof. Naila Hoacine has rejected your swap request for Computer Networks on March 3, 2025.',
        timeAgo: '10 minutes ago',
      ),
      NotificationItem(
        type: 'Schedule Change',
        title: 'Schedule Change',
        message: 'Your Algorithms class on Tuesday has been moved to Room B101D.',
        timeAgo: '10 minutes ago',
        roomChange: 'Room B101D',
      ),
      NotificationItem(
        type: 'New Swap Request',
        title: 'New Swap Request',
        message: 'Prof. John Doe has requested to swap Chemistry 101 on March 26, 2025 for Biology 303.',
        timeAgo: '1 hour ago',
      ),
      NotificationItem(
        type: 'Swap Request Accepted',
        title: 'Swap Request Accepted',
        message: 'Your request for "Data Structures" was accepted by Prof. Jane Smith.',
        timeAgo: '2 hours ago',
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 5 tabs: All, Pending, Accepted, Rejected, Alerts
    _notificationsFuture = _fetchNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper to filter notifications based on the selected tab
  List<NotificationItem> _filterNotifications(List<NotificationItem> allNotifications, String tab) {
    switch (tab) {
      case 'All':
        return allNotifications;
      case 'Pending':
        return allNotifications.where((n) => n.type == 'New Swap Request' && n.status == null).toList();
      case 'Accepted':
        return allNotifications.where((n) => n.type == 'Swap Request Accepted').toList();
      case 'Rejected':
        return allNotifications.where((n) => n.type == 'Swap Request Rejected').toList();
      case 'Alerts':
        return allNotifications.where((n) => n.type == 'Schedule Change').toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Stay updated with your swap requests and schedule changes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Tabs for filtering notifications
          Container(
  height: 40, // Height for the TabBar
  // Removed explicit background color here, as the TabBar will handle its own color for selected/unselected.
  decoration: BoxDecoration(
    color: Colors.grey[100], // Background color for the entire tab bar container
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey.shade300), // Add a subtle border
  ),
  child: TabBar(
    controller: _tabController,
    // Adjust indicator for a more refined look (similar to the image)
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blue.shade700,
    ),
    // Make the indicator cover the entire tab content area
    indicatorSize: TabBarIndicatorSize.tab, // This makes the indicator fill the tab space
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey[700],
    // Adjust label padding to give more internal spacing to the tabs
    labelPadding: const EdgeInsets.symmetric(horizontal: 10), // Adjust as needed
    // Add spacing between tabs if desired, though the indicator takes care of most of it.
    // Setting an explicit tab bar padding might also help if your tabs feel too cramped
    // Or you can put the TabBar inside a Padding widget if the container itself doesn't provide enough space.
    tabs: const [
      Tab(text: 'All'),
      Tab(text: 'Pending'),
      Tab(text: 'Accepted'),
      Tab(text: 'Rejected'),
      Tab(text: 'Alerts'),
    ],
    onTap: (index) {
      setState(() {
        // Re-fetch or re-filter notifications based on the selected tab
        // For this example, we'll re-filter from the fetched data
        _notificationsFuture = _fetchNotifications(); // Re-fetch all, then filter
      });
    },
  ),
),
            const SizedBox(height: 20),

            // Notification List based on Tab
            Expanded(
              child: FutureBuilder<List<NotificationItem>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No notifications available.'));
                  } else {
                    // Filter notifications based on the current tab
                    final String currentTab = _tabController.index == 0
                        ? 'All'
                        : _tabController.index == 1
                            ? 'Pending'
                            : _tabController.index == 2
                                ? 'Accepted'
                                : _tabController.index == 3
                                    ? 'Rejected'
                                    : 'Alerts';
                    final filteredNotifications = _filterNotifications(snapshot.data!, currentTab);

                    if (filteredNotifications.isEmpty) {
                      return Center(child: Text('No $currentTab notifications.'));
                    }

                    return ListView.builder(
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];
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
                                Text(
                                  notification.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  notification.message,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    notification.timeAgo,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                if (notification.type == 'New Swap Request')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Handle Accept logic
                                            print('Accept swap request for ${notification.message}');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue.shade700,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Accept'),
                                        ),
                                        const SizedBox(width: 10),
                                        OutlinedButton(
                                          onPressed: () {
                                            // Handle Decline logic
                                            print('Decline swap request for ${notification.message}');
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Colors.grey.shade400),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Decline'),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (notification.type == 'Swap Request Accepted' ||
                                    notification.type == 'Swap Request Rejected' ||
                                    notification.type == 'Schedule Change')
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Handle View Details logic
                                        print('View details for ${notification.title}');
                                      },
                                      child: const Text('View Details'),
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
          ],
        ),
      ),
    );
  }
}