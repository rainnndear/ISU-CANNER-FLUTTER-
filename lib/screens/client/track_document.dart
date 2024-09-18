import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  @override
  State<TrackOrderScreen> createState() => TrackOrderScreenState();
}

class TrackOrderScreenState extends State<TrackOrderScreen> {
  // Sample data for the order statuses
  final List<OrderStatus> statusList = [
    OrderStatus(
      time: 'Sep 19 1:04 PM',
      status: 'Complete',
      description: 'Your request is now on office 3',
      location: 'Supply Budgeting',
      imageUrl: 'https://via.placeholder.com/150',
      carrier: 'name of staff',
      isFinal: true,
    ),
    OrderStatus(
      time: '7:37 AM',
      status: 'complete',
      description: 'Your request is now on office 4',
      location: 'Officename',
      carrier: 'Mark Erdie Tabelin Dumlao',
      phoneNumber: '09274401952',
    ),
    OrderStatus(
      time: '3:09 AM',
      status: 'complete',
      description: 'Your request is now on office 3',
      location: 'Officename',
      carrier: 'name of staff',
    ),
    OrderStatus(
      time: 'Sep 18 10:02 PM',
      status: 'complete',
      description: 'Your request is now on office 2',
      location: 'Officename',
      carrier: 'name of staff',
    ),
    OrderStatus(
      time: '3:59 PM',
      status: 'complete',
      description: 'Your request is now on office 1',
      location: 'Officename',
      carrier: 'name of staff',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Document'),
      ),
      body: ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) {
          final item = statusList[index];
          return OrderStatusWidget(item: item);
        },
      ),
    );
  }
}

// Define the OrderStatus model
class OrderStatus {
  final String time;
  final String status;
  final String description;
  final String location;
  final String? carrier;
  final String? phoneNumber;
  final String? imageUrl; // To hold the URL of an image if available
  final bool isFinal;

  OrderStatus({
    required this.time,
    required this.status,
    required this.description,
    required this.location,
    this.carrier,
    this.phoneNumber,
    this.imageUrl, // Add imageUrl parameter to the model
    this.isFinal = false,
  });
}

// The widget for displaying each order status
class OrderStatusWidget extends StatelessWidget {
  final OrderStatus item;

  const OrderStatusWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: item.isFinal ? Colors.green : Colors.grey,
              size: 24.0,
            ),
            SizedBox(width: 8.0),
            Text(
              item.time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.status,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 4.0),
              Text(item.description),
              SizedBox(height: 4.0),
              Text(item.location, style: TextStyle(color: Colors.grey)),
              if (item.carrier != null || item.phoneNumber != null) ...[
                SizedBox(height: 4.0),
                Text('Carrier: ${item.carrier}', style: TextStyle(color: Colors.blue)),
                Text('Phone: ${item.phoneNumber}', style: TextStyle(color: Colors.blue)),
              ],
              // Add image if available
              if (item.imageUrl != null) ...[
                SizedBox(height: 8.0),
                Image.network(
                  item.imageUrl!,
                  height: 100.0, // Adjust height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ]
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
