import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DraggableChatButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String riveAsset;

  const DraggableChatButton({
    super.key,
    required this.onPressed,
    required this.riveAsset,
  });

  @override
  _DraggableChatButtonState createState() => _DraggableChatButtonState();
}

class _DraggableChatButtonState extends State<DraggableChatButton> {
  // La position initiale du bouton
  Offset _buttonPosition = const Offset(100, 300);

  @override
  Widget build(BuildContext context) {
    // Le Stack permet de positionner des widgets de manière absolue
    return Stack(
      children: [
        Positioned(
          left: _buttonPosition.dx,
          top: _buttonPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Met à jour la position du bouton lors du glisser
              setState(() {
                _buttonPosition += details.delta;
              });
            },
            child: FloatingActionButton(
              onPressed: widget.onPressed,
              child: ClipOval(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: RiveAnimation.asset(
                    widget.riveAsset,
                    fit: BoxFit.cover, // Remplit le conteneur
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}