import 'package:flutter/material.dart';

import '../widget/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
                SizedBox(
                  width: w / 3.2,
                ),
                textButton(name: 'City'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
