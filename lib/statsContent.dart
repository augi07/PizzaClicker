import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsContent extends StatefulWidget {
  const StatsContent({Key? key}) : super(key: key);

  @override
  State<StatsContent> createState() => _StatsContentState();
}

class _StatsContentState extends State<StatsContent> {
  int totalPizzas = 0;
  int pizzasPerClick = 1;
  int upgradesPurchased = 0;

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPizzas = prefs.getInt('totalPizzas') ?? 0;
      pizzasPerClick = prefs.getInt('pizzasPerClick') ?? 1;
      upgradesPurchased = prefs.getInt('upgradesPurchased') ?? 0;
    });
  }

  Future<void> buyUpgrade(int cost, int type) async {
    if (totalPizzas < cost) return;

    final prefs = await SharedPreferences.getInstance();
    totalPizzas -= cost;
    upgradesPurchased++;

    switch (type) {
      case 1:
        pizzasPerClick += 1;
      case 2:
        pizzasPerClick += 10;
      case 3:
        pizzasPerClick += 20;
      case 4:
        pizzasPerClick += 1000;
      case 5:
        pizzasPerClick += 10000;
      case 6:
        pizzasPerClick += 100000;
    }

    await prefs.setInt('totalPizzas', totalPizzas);
    await prefs.setInt('pizzasPerClick', pizzasPerClick);
    await prefs.setInt('upgradesPurchased', upgradesPurchased);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  Widget statCard(String title, Map<String, dynamic> stats) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? Colors.black : Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor)),
          ...stats.entries.map((e) => Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.key,
                        // ignore: deprecated_member_use
                        style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.8))),
                    Text(e.value.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget upgradeOption(String name, String desc, int cost, int type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black)),
            Text(desc,
                style: TextStyle(
                    fontSize: 14, color: isDark ? Colors.white70 : Colors.black87)),
          ]),
          ElevatedButton(
            onPressed: () => buyUpgrade(cost, type),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 213, 225, 255),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text('Buy: $cost 🍕'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final prefs = snapshot.data!;
        totalPizzas = prefs.getInt('totalPizzas') ?? 0;

        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  statCard("Pizza Stats", {
                    "Total Pizzas": totalPizzas,
                    "Pizzas per Click": pizzasPerClick,
                  }),
                  statCard("Achievements", {
                    "Upgrades Purchased": upgradesPurchased,
                  }),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? Colors.black : Colors.white,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Upgrades",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black)),
                        upgradeOption("Double Click", "+1 per click", 50, 1),
                        upgradeOption("Golden Pizza", "+10 per click", 500, 2),
                        upgradeOption("Super Click", "+20 per click", 10000, 3),
                        upgradeOption("Mega Multiplier", "+1000 per click", 100000, 4),
                        upgradeOption("Ultra Multiplier", "+10000 per click", 200000, 5),
                        upgradeOption("Clickstorm", "+100000 per click", 9999999, 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}