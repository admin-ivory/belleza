import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QirikuToggle extends StatefulWidget {
  final String riveAsset;
  final String stateMachineName;

  const QirikuToggle({
    super.key,
    required this.riveAsset,
    required this.stateMachineName,
  });

  @override
  _QirikuToggleState createState() => _QirikuToggleState();
}

class _QirikuToggleState extends State<QirikuToggle> {
  // Variable pour stocker l'état du switch
  bool _isQirikuEnabled = false;

  // Variables pour Rive
  Artboard? _riveArtboard;
  StateMachineController? _stateMachineController;
  SMIInput<bool>? _riveActiveInput;

  @override
  void initState() {
    super.initState();
    _loadAssistantState();
    _loadRiveFile();
  }

  // Charge l'état de l'assistant depuis SharedPreferences
  Future<void> _loadAssistantState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isQirikuEnabled = prefs.getBool('isQirikuEnabled') ?? false;
    });
  }

  // Sauvegarde l'état de l'assistant dans SharedPreferences
  Future<void> _saveAssistantState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isQirikuEnabled', value);
  }

  // Charge le fichier Rive et son contrôleur
  void _loadRiveFile() async {
    try {
      final ByteData data = await rootBundle.load(widget.riveAsset);
      final RiveFile file = RiveFile.import(data);
      _riveArtboard = file.mainArtboard;
      _stateMachineController = StateMachineController.fromArtboard(
        _riveArtboard!,
        widget.stateMachineName,
      );

      if (_stateMachineController != null) {
        _riveArtboard!.addController(_stateMachineController!);
        _riveActiveInput = _stateMachineController!.findInput<bool>('isActive');
        _riveActiveInput?.value = _isQirikuEnabled; // Synchronise l'état initial
        setState(() {});
      }
    } catch (e) {
      debugPrint("Erreur lors du chargement du fichier Rive : $e");
    }
  }

  // Met à jour l'état de Rive et l'état local
  void _onToggleChanged(bool value) {
    setState(() {
      _isQirikuEnabled = value;
    });
    _saveAssistantState(value);
    _riveActiveInput?.value = value; // Met à jour l'input Rive
  }

  @override
  void dispose() {
    _stateMachineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 60,
      child: _riveArtboard == null
          ? const CircularProgressIndicator()
          : Rive(
        artboard: _riveArtboard!,
        fit: BoxFit.contain,
      ),
    );
  }
}

// Exemple d'utilisation dans votre application:
// QirikuToggle(
//   riveAsset: 'assets/cat_toggle.riv', // Nom de votre fichier Rive
//   stateMachineName: 'State Machine 1', // Nom de votre machine d'état
// )
