import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:user/app/helper/shared_pref.dart';


class DraggableChatButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String riveAsset;
  final Q_SharedPreferencesManager q_sharedPreferencesManager;
  const DraggableChatButton({
    super.key,
    required this.onPressed,
    required this.riveAsset,
    required this.q_sharedPreferencesManager,

  });


  @override
  _DraggableChatButtonState createState() => _DraggableChatButtonState();

}

class Q_SharedPreferencesManager {
  SharedPreferencesManager? q_sharedPreferencesManager;
  static const String keyAccessToken = 'accessToken';
  static const String keyUserData = 'user_data';
  static const String keyRole = 'user_role';
  static const String keyFcmToken = 'fcm_token';


}

class _DraggableChatButtonState extends State<DraggableChatButton> {
  Offset _buttonPosition = const Offset(100, 300);



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _buttonPosition.dx,
          top: _buttonPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _buttonPosition += details.delta;
              });
            },
            child:
            FloatingActionButton(
              onPressed: () {
                if (widget.q_sharedPreferencesManager != null) {
                  widget.onPressed();
                } else {
                  // Afficher un message ou rediriger vers login
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please log in first')),
                  );
                }
              },
              child: ClipOval(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: RiveAnimation.asset(
                    widget.riveAsset,
                    fit: BoxFit.cover,
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
