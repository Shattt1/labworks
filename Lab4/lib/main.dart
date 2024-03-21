import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:map_launcher/map_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int likeCount = 447;
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
  }

  void callNumber() async {
    final Uri url = Uri(
      scheme: 'tel',
      path: "999 888 7777",
    );
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Не удалось совершить вызов.';
    }
  }

  void openMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    availableMaps.forEach((map) {
      print(map.icon);
      print(map.mapName);
      print(map.mapType);
    });

    if (availableMaps.isNotEmpty) {
      final firstMap = availableMaps.first;
      await firstMap.showMarker(
        coords: Coords(45.05030190357135, 38.92076165803231),
        title: "Общежитие №20",
        zoom: 50,
      );
    }
  }

  void share() {
    const String text = 'Посетите общежитие №20';
    const String url = 'https://www.kubsau.ru/';
    Share.share('$text\n$url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Общежития КубГАУ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/58_big.jpg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Общежитие №20',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Краснодар, ул. Калинина 13',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: toggleLike,
                        icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border),
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      Text(
                        'likeCount', // Количество лайков
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: callNumber,
                            icon: const Icon(Icons.phone, color: Colors.green),
                          ),
                          const Text(
                            'Позвонить',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: openMap,
                            icon: const Icon(Icons.directions,
                                color: Colors.green),
                          ),
                          const Text(
                            'Маршрут',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: share,
                            icon: const Icon(Icons.share, color: Colors.green),
                          ),
                          const Text(
                            'Поделиться',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
