import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/response/TripGetRespone.dart';
import 'package:my_first_app/pages/profile.dart';
import 'package:my_first_app/pages/trip.dart';

class ShowtripPage extends StatefulWidget {
  int cid = 0;
  ShowtripPage({super.key, required this.cid});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage> {
  String url = '';
  List<TripGetRespone> tripGetResponses = [];
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getTrips();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      getTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("รายการทริป"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idx: widget.cid),
                  ),
                );
              } else if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('ข้อมูลส่วนตัว'), value: 'profile'),
              PopupMenuItem(child: Text('logout'), value: 'logout'),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ปลายทาง"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              loadData = getTrips();
                            });
                          },
                          child: Text("ทั้งหมด"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRespone> asiaTrips = [];
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'เอเชีย') {
                                asiaTrips.add(trip);
                              }
                            }
                            setState(() {
                              tripGetResponses = asiaTrips;
                            });
                          },
                          child: Text("เอเชีย"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRespone> euroTrips = [];
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'ยุโรป') {
                                euroTrips.add(trip);
                              }
                            }
                            setState(() {
                              tripGetResponses = euroTrips;
                            });
                          },
                          child: Text("ยุโรป"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRespone> aseanTrips = [];
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone ==
                                  'เอเชียตะวันออกเฉียงใต้') {
                                aseanTrips.add(trip);
                              }
                            }
                            setState(() {
                              tripGetResponses = aseanTrips;
                            });
                          },
                          child: Text("อาเซียน"),
                        ),
                        FilledButton(onPressed: () {}, child: Text("แอฟริกา")),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRespone> thaiTrips = [];
                            for (var trip in tripGetResponses) {
                              if (trip.destinationZone == 'ประเทศไทย') {
                                thaiTrips.add(trip);
                              }
                            }
                            setState(() {
                              tripGetResponses = thaiTrips;
                            });
                          },
                          child: Text("ไทย"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: tripGetResponses
                        .map(
                          (trip) => Card(
                            child: Column(
                              children: [
                                Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      10.0,
                                    ), // Adjust padding as needed
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trip.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Image section
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8.0,
                                                  ), // Rounded corners for image
                                              child: Image.network(
                                                trip.coverimage,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        width: 120,
                                                        height: 120,
                                                        color: Colors.grey[300],
                                                        child: Icon(
                                                          Icons.broken_image,
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                                    },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ), // Space between image and text
                                            // Text details and button section
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("ประเทศ${trip.country}"),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "ระยะเวลา ${trip.duration} วัน",
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "ราคา ${trip.price} บาท",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FilledButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => TripPage(
                                                                  idx: trip.idx,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                      style: FilledButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                              0xFF8A6BA6,
                                                            ), // Custom color from image
                                                      ),
                                                      child: const Text(
                                                        "รายละเอียดเพิ่มเติม",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getTrips() async {
    var config = await Configuration.getConfig();
    url = config["apiEndpoint"];

    var res = await http.get(Uri.parse('$url/trips'));
    log(res.body);

    // setState(() {
    tripGetResponses = tripGetResponeFromJson(res.body);
    log(tripGetResponses.length.toString());
    // });
  }
}
