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
            "https://celes.club/uploads/posts/2022-09/thumbs/1662061006_4-celes-club-p-peristie-oblaka-instagram-6.jpg",
            fit: BoxFit.cover,
            height: h,
          ),
          SafeArea(
              child: Column(
            children: [
              const Text(
                "Weather App",
                style: TextStyle(fontSize: 22),
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
                      pressure = snapshot.data['main']['pressure'];
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
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              ApiString.city,
                              style: const TextStyle(fontSize: 28),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(now),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Lat\n$latitude",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    weatherStatus.getWeatherIcon(snapshot.data!['cod']),
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                  Text(
                                    "Lon\n$longitude",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${temp.toInt()} °C",
                              style: const TextStyle(fontSize: 40),
                            ),
                            Text(
                              ApiString.des,
                              style: const TextStyle(fontSize: 25),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Speed",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 23),
                                          ),
                                          Text(
                                            "$speed",
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Pressure",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 23),
                                          ),
                                          Text(
                                            "$pressure",
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 110,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Humidity",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 23),
                                        ),
                                        Text(
                                          "$humidity",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 110,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Visibility",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 23),
                                        ),
                                        Text(
                                          "$visibility",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
