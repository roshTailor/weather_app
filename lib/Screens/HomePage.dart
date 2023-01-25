import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/class/weatherStatus.dart';
import 'package:weather_app/utils/apiString.dart';
import 'package:get/get.dart';

import '../services/httpServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  final weatherStatus = Get.put(WeatherStatus());
  TextEditingController textEditingController = TextEditingController();
  num temp = 0,
      longitude = 0,
      latitude = 0,
      speed = 0,
      pressure = 0,
      humidity = 0,
      visibility = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://gazettengr.com/wp-content/uploads/sunny-weather.jpg",
            fit: BoxFit.cover,
            height: h,
          ),
          SafeArea(
              top: true,
              right: true,
              left: true,
              minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: h / 80,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      DateFormat.yMMMMd().format(now),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: h / 80,
                  ),
                  CupertinoSearchTextField(
                    controller: textEditingController,
                    backgroundColor: Colors.white,
                    onSuffixTap: () {
                      setState(() {
                        ApiString.city = "Surat";
                        textEditingController.clear();
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        ApiString.city = val;
                        HttpService().getWeatherResponse();
                        print(ApiString.city);
                      });
                    },
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: HttpService().getWeatherResponse(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          temp = snapshot.data['main']['temp'] - 273;
                          humidity = snapshot.data['main']['humidity'];
                          longitude = snapshot.data['coord']['lon'];
                          latitude = snapshot.data['coord']['lat'];
                          speed = snapshot.data['wind']['speed'];
                          // var weatherIcon =
                          //     weatherStatus.getWeatherIcon(snapshot.data!.cod);
                          visibility = snapshot.data['visibility'];
                          ApiString.city = snapshot.data['name'];
                          ApiString.des =
                              snapshot.data['weather'][0]['description'];
                          return Column(
                            children: [
                              SizedBox(
                                height: h / 10,
                              ),
                              Text(
                                ApiString.city,
                                style: const TextStyle(fontSize: 28),
                              ),
                              Text(
                                "${temp.toInt()} °C",
                                style: const TextStyle(fontSize: 40),
                              ),
                              Text(
                                ApiString.des,
                                style: const TextStyle(fontSize: 25),
                              ),
                              Spacer(),
                              const Align(
                                alignment: Alignment(-1, 0),
                                child: Text(
                                  "Details",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                              Container(
                                height: 140,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Lat\n${snapshot.data['coord']['lat']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        /*Text(
                                          weatherStatus.getWeatherIcon(
                                              snapshot.data!['cod']),
                                          style: const TextStyle(fontSize: 60),
                                        ),*/
                                        Text(
                                          weatherStatus.getWeatherIcon(
                                              800),
                                          style: const TextStyle(fontSize: 50),
                                        ),
                                        Text(
                                          "Lon\n$longitude",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Speed",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "$speed",
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Pressure",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "${snapshot.data['main']['pressure']}",
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Humidity",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "$humidity",
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Visibility",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "$visibility",
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: const Alignment(-1, 0),
                                  child: Text(
                                    weatherStatus.getMessage(
                                      temp.toInt(),
                                    ),style:
                                  const TextStyle(fontSize: 16),
                                  ),)
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
