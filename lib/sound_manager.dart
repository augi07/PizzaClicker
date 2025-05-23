import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundManager {
  static const int _poolSize = 5; // Cuántos reproductores tener listos
  static final List<AudioPlayer> _players =
      List.generate(_poolSize, (_) => AudioPlayer());
  static int _currentIndex = 0;

  static Future<void> playClickSound() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('soundEffects') ?? true;
    final volume = prefs.getDouble('volume') ?? 0.5;

    if (!enabled) return;

    final player = _players[_currentIndex];
    _currentIndex = (_currentIndex + 1) % _poolSize;

    await player.stop();
    await player.setVolume(volume);
    await player.play(AssetSource('sounds/click.mp3'));
  }
}
