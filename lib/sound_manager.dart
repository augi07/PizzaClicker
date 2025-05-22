import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playClickSound() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('soundEffects') ?? true;
    final volume = prefs.getDouble('volume') ?? 0.5;

    if (!enabled) return;

    await _player.setVolume(volume);
    await _player.play(AssetSource('sounds/Click.mp3'));
  }
}
