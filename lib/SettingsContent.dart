import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'app_settings.dart';


class SettingsContent extends StatefulWidget {
  final VoidCallback onReset;

  SettingsContent({required this.onReset});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  bool darkMode = false;
  bool animations = true;
  bool soundEffects = true;
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
      animations = prefs.getBool('animations') ?? true;
      soundEffects = prefs.getBool('soundEffects') ?? true;
      volume = prefs.getDouble('volume') ?? 0.5;
    });
  }

  Future<void> _updateBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _updateDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  void resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', 0);
    await prefs.setInt('totalPizzas', 0);
    await prefs.setInt('pizzasPerClick', 1);
    await prefs.setInt('upgradesPurchased', 0);
    widget.onReset();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppearanceSettings(),
            _buildSoundSettings(),
            _buildGameSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return _settingsContainer(
      title: 'Appearance',
      height: 170,
      children: [
        _buildSwitchRow('Dark Mode', darkMode, (val) {
          setState(() => darkMode = val);
          _updateBool('darkMode', val);
          context.read<AppSettings>().setDarkMode(val);
        }),
        _buildSwitchRow('Animations', animations, (val) {
          setState(() => animations = val);
          _updateBool('animations', val);
          context.read<AppSettings>().setAnimationsEnabled(val);
        }),
      ],
    );
  }

  Widget _buildSoundSettings() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return _settingsContainer(
      title: 'Sound',
      height: 220,
      children: [
        _buildSwitchRow('Sound Effects', soundEffects, (val) {
          setState(() => soundEffects = val);
          _updateBool('soundEffects', val);
        }),
        const SizedBox(height: 10),
        Text('Volume', style: TextStyle(fontSize: 16, color: textColor)),
        Row(
          children: [
            Expanded(
              child: Slider(
                activeColor: Colors.black,
                value: volume,
                min: 0.0,
                max: 1.0,
                onChanged: (val) {
                  setState(() => volume = val);
                  _updateDouble('volume', val);
                },
              ),
            ),
            Text('${(volume * 100).round()}%', style: TextStyle(color: textColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildGameSettings() {
    return _settingsContainer(
      title: 'Game',
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 270,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color.fromARGB(209, 255, 204, 204)),
              foregroundColor: WidgetStateProperty.all(Colors.red),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            onPressed: resetProgress,
            child: const Text('Reset Progress'),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: textColor)),
        Switch(
          activeTrackColor: Colors.black,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _settingsContainer({
    required String title,
    required double height,
    required List<Widget> children,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 30),
      width: 320,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: isDark ? Colors.grey[850] : Colors.white,
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor)),
          ...children,
        ],
      ),
    );
  }
}