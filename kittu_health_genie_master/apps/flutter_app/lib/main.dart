import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KittU Health Genie',
      theme: ThemeData.dark(),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map data = {};

  Future fetchVitals() async {
    final res = await http.get(Uri.parse("http://127.0.0.1:8000/vitals"));
    setState(() {
      data = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchVitals();
  }

  Widget glassCard(String title,String value){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.2),
            blurRadius: 25,
          )
        ]
      ),
      child: Column(
        children: [
          Text(title,style: const TextStyle(fontSize:16,color: Colors.white70)),
          const SizedBox(height:8),
          Text(value,style: const TextStyle(fontSize:28,fontWeight: FontWeight.bold,color: Colors.cyanAccent))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050b18),
      appBar: AppBar(
        title: const Text("🧠 KittU Health Genie"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan.withOpacity(0.2),
                    Colors.blue.withOpacity(0.05)
                  ]
                ),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.5))
              ),
              child: const Center(
                child: Text(
                  "🧍‍♂️ HOLOGRAPHIC DIGITAL TWIN BODY",
                  style: TextStyle(fontSize:26,color: Colors.cyanAccent),
                ),
              ),
            ),

            const SizedBox(height:20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: [
                  glassCard("❤️ Heart", "${data["heart_rate"] ?? "--"} bpm"),
                  glassCard("🫁 Oxygen", "${data["oxygen"] ?? "--"}%"),
                  glassCard("🌡 Temp", "${data["temp"] ?? "--"} °C"),
                  glassCard("🤖 AI Risk", "${data["risk"] ?? "--"}"),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: fetchVitals,
              child: const Text("🔄 Refresh Live Data"),
            )

          ],
        ),
      ),
    );
  }
}
