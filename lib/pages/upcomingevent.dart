
/*
import 'package:flutter/material.dart';
import 'constants.dart';
import '../constants/containerconstants.dart';
import '../constants/imageconstants.dart';
import '../constants/textconstants.dart';
import '../constants/iconconstants.dart';
class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({super.key});

  @override
  _UpcomingEventState createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  final List<Map<String, String>> _events = [
    {
      'title': 'Youth Empowerment Summit',
      'description': 'A summit focused on empowering the youth with skills and leadership training.',
      'date': 'March 22, 2024',
      'location': 'Accra, Ghana',
    },
    {
      'title': 'Policy Development Workshop',
      'description': 'Join policymakers and civic leaders in discussing the future of education policy.',
      'date': 'April 5, 2024',
      'location': 'Kumasi, Ghana',
    },
    {
      'title': 'Community Health Fair',
      'description': 'Free health services and education provided by local healthcare professionals.',
      'date': 'May 10, 2024',
      'location': 'Tamale, Ghana',
    },
  ];

  String _searchQuery = "";
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    // Filter the event list based on the search query
    List<Map<String, String>> _filteredEvents = _events.where((event) {
      final eventTitle = event['title']!.toLowerCase();
      final eventLocation = event['location']!.toLowerCase();
      final searchLower = _searchQuery.toLowerCase();
      return eventTitle.contains(searchLower) || eventLocation.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextFormField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Events...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        )
            : const Text('Upcoming Events',style: TextStyle(color: ConstantsTextColor.logintext,fontSize: 12.0),),
        backgroundColor: ContainerConstants.appBarColor,
        iconTheme: const IconThemeData(
          color: ConstantsIcon.iconWhite,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child:  Text(
                    'Upcoming Civic Society Events',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Event List
                Expanded(
                  child: _filteredEvents.isEmpty
                      ? const Center(child: Text('No events found.',style: TextStyle(fontSize: 12.0),))
                      : ListView.builder(
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return _buildEventItem(
                        title: event['title']!,
                        description: event['description']!,
                        date: event['date']!,
                        location: event['location']!,
                        context: context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


   _buildEventItem({
    required String title,
    required String description,
    required String date,
    required String location,
    required BuildContext context,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            Text('Date: $date',style: const TextStyle(fontSize: 12.0),),
            Text('Location: $location',style: const TextStyle(fontSize: 12.0),),
          ],
        ),
        trailing: const Icon(Icons.event),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventDetailPage(
              title: title,
              description: description,
              date: date,
              location: location,
            ),
          ));
        },
      ),
    );
  }
}


class EventDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String location;

  EventDetailPage({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details',style: TextStyle(color: ConstantsTextColor.logintext,fontSize: 12.0,),
        ),
        backgroundColor: ContainerConstants.appBarColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: ConstantsIcon.iconWhite
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Date: $date',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Location: $location',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import '../constants/containerconstants.dart';
import '../constants/imageconstants.dart';
import '../constants/textconstants.dart';
import '../constants/iconconstants.dart';

class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({super.key});

  @override
  _UpcomingEventState createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  List<Map<String, dynamic>> _events = [];
  String _searchQuery = "";
  bool _isSearching = false;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  // Fetch events from the API
  Future<void> fetchEvents() async {
    final url = 'https://your-api-endpoint.com/events'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _events = data.map((event) => {
            'title': event['title'],
            'description': event['description'],
            'date': event['date'],
            'location': event['location'],
          }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter the event list based on the search query
    List<Map<String, dynamic>> _filteredEvents = _events.where((event) {
      final eventTitle = event['title']!.toLowerCase();
      final eventLocation = event['location']!.toLowerCase();
      final searchLower = _searchQuery.toLowerCase();
      return eventTitle.contains(searchLower) || eventLocation.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextFormField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Events...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        )
            : const Text(
          'Upcoming Events',
          style: TextStyle(color: ConstantsTextColor.logintext, fontSize: 12.0),
        ),
        backgroundColor: ContainerConstants.appBarColor,
        iconTheme: const IconThemeData(
          color: ConstantsIcon.iconWhite,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? const Center(child: Text('Failed to load events.'))
          : Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Upcoming Civic Society Events',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Event List
                Expanded(
                  child: _filteredEvents.isEmpty
                      ? const Center(child: Text('No events found.', style: TextStyle(fontSize: 12.0)))
                      : ListView.builder(
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return _buildEventItem(
                        title: event['title']!,
                        description: event['description']!,
                        date: event['date']!,
                        location: event['location']!,
                        context: context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildEventItem({
    required String title,
    required String description,
    required String date,
    required String location,
    required BuildContext context,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            Text('Date: $date', style: const TextStyle(fontSize: 12.0)),
            Text('Location: $location', style: const TextStyle(fontSize: 12.0)),
          ],
        ),
        trailing: const Icon(Icons.event),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventDetailPage(
              title: title,
              description: description,
              date: date,
              location: location,
            ),
          ));
        },
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String location;

  EventDetailPage({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: ConstantsTextColor.logintext,
            fontSize: 12.0,
          ),
        ),
        backgroundColor: ContainerConstants.appBarColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: ConstantsIcon.iconWhite),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Date: $date',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Location: $location',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
