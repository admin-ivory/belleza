import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/rive_controller.dart'; // ta classe RiveMultiController ici

class QirikuIntroPage extends StatefulWidget {
  const QirikuIntroPage({super.key});

  @override
  State<QirikuIntroPage> createState() => _QirikuIntroPageState();
}

class _QirikuIntroPageState extends State<QirikuIntroPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  // Instanciation de ton multi controller
  final RiveMultiController _riveController = RiveMultiController();

  final List<String> _introPages = [
    "Hey, moi c'est Qiriku, ton assistant beauté. Réponds à ces quelques questions pour que je puisse mieux t'aider !",
    'Question 1: Quelle est la texture de vos cheveux ?',
    'Question 2: Quel est votre style de coiffure préféré ?',
    "Question 3: Avez-vous une photo d'inspiration ?",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _riveController.dispose();
    super.dispose();
  }

  void _onNextStep() {
    if (_currentPageIndex < _introPages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease).then((_) {
        final currentPage = _pageController.page;
        if (currentPage != null && mounted) {
          setState(() {
            _currentPageIndex = currentPage.round();
            // Met à jour l'input 'step' pour rive1 (par exemple)
            _riveController.setInputValue('rive1', 'step', _currentPageIndex.toDouble());
          });
        }
      });
    } else {
      _riveController.setInputValue('rive1', 'thunderGodMode', true);
      _completeIntro();
    }
  }

  Future<void> _completeIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenQirikuIntro', true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Widget _buildTimelineIndicator(int step) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _currentPageIndex >= step ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildIntroPage(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))
            ],
          ),
          child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.black87)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenue, je suis Qiriku !')),
      body: Column(
        children: [
          // Partie haute : animation Rive qui occupe 50% de la hauteur
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: RiveAnimation.asset(
              'assets/rive/oni.riv',
              fit: BoxFit.cover,
              onInit: (artboard) {
                _riveController.init(
                  key: 'rive1',
                  artboard: artboard,
                  stateMachineName: 'State Machine 1',
                  inputNames: ['step', 'thunderGodMode'],
                );
                setState(() {});
              },
            ),
          ),

          // Partie basse : contenu questions + smooth_sheets
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _introPages.length,
                          (index) => _buildTimelineIndicator(index),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (mounted) {
                        setState(() {
                          _currentPageIndex = index;
                          _riveController.setInputValue('rive1', 'step', _currentPageIndex.toDouble());
                        });
                      }
                    },
                    children: _introPages.map((text) => _buildIntroPage(text)).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _onNextStep,
                    child: Text(
                      _currentPageIndex == _introPages.length - 1 ? 'Terminer' : 'Suivant',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
