import 'package:rive/rive.dart';

class RiveMultiController {
  final Map<String, StateMachineController> _controllers = {};
  final Map<String, Map<String, SMIInput>> _inputs = {};

  /// Initialise un artboard avec sa clé unique, son nom de state machine et la liste des inputs à récupérer
  void init({
    required String key,
    required Artboard artboard,
    required String stateMachineName,
    required List<String> inputNames,
  }) {
    final controller = StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
      _controllers[key] = controller;
      _inputs[key] = {};

      for (final inputName in inputNames) {
        final input = controller.findInput(inputName);
        if (input != null) {
          _inputs[key]![inputName] = input;
        }
      }
    }
  }

  /// Met à jour la valeur d’un input spécifique
  void setInputValue(String key, String inputName, dynamic value) {
    final input = _inputs[key]?[inputName];
    if (input != null) {
      if (input is SMINumber && (value is num)) {
        input.value = value.toDouble();
      } else if (input is SMIBool && value is bool) {
        input.value = value;
      } else if (input is SMITrigger && value == true) {
        input.fire();
      }
    }
  }

  /// Récupérer le contrôleur si besoin
  StateMachineController? getController(String key) => _controllers[key];

  /// Libère les ressources
  void dispose() {
    for (var ctrl in _controllers.values) {
      ctrl.dispose();
    }
    _controllers.clear();
    _inputs.clear();
  }
}
