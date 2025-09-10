import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/response/TripGetRespone.dart';
import 'package:my_first_app/model/response/tripIdxGetResponse.dart';

class TripPage extends StatefulWidget {
  int idx = 0;
  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String url = '';
  late Future<void> loadData;
  late TripIdxGetResponse tripIdxGetResponse;
  @override
  void initState() {
    super.initState();
    // Call async function
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียดทริป")),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          // Loading...
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          // Load Done
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tripIdxGetResponse.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    tripIdxGetResponse.country,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Image.network(
                  tripIdxGetResponse.coverimage,

                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ราคา ${tripIdxGetResponse.price} บาท"),
                    Text("โซน${tripIdxGetResponse.destinationZone}"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 3),
                  child: Text(
                    tripIdxGetResponse.detail,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF8A6BA6,
                      ), // Custom color from image
                    ),
                    child: const Text("จองเลย!!"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config["apiEndpoint"];
    var res = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    log(res.body);
    tripIdxGetResponse = tripIdxGetResponseFromJson(res.body);
  }
}
