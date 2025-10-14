import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:redacted/redacted.dart';

import '../../controller/home_controller.dart';
import '../../env.dart';
import '../theme.dart';

class SaloonWidget extends StatelessWidget {
  const SaloonWidget({super.key});

// ...

  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (value) {
        // Le return doit être ici pour renvoyer le widget
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Permet le défilement horizontal
          padding:
          const EdgeInsets.symmetric(horizontal: 5), // Marge de début/fin
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // La boucle pour générer chaque carte de salon
              for (var item in value.salonList)
                InkWell(
                  onTap: () {
                    // Logique de navigation vers les détails du salon
                    // controller.onServices(item.uid as int);
                  },
                  child: Container(
                    // La marge assure l'espacement entre les cartes
                    margin:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    height: 260,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100.withOpacity(0.6),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Zone Image et Badges (via Stack)
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                          child: SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                // Image de fond
                                FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}/storage/images/${item.cover.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover);
                                  },
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),

                                // Badge 1 (Distance : Haut Gauche)
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.white, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${item.distance?.toStringAsFixed(1) ?? 'N/A'} km',
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Badge 2 (Notation : Haut Droit)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star_rounded,
                                            color: Colors.white, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          item.rating?.toStringAsFixed(1) ??
                                              '0.0',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          ' (${item.totalRating})',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 2. Zone de Texte et Détails
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Répétition de la notation dans la section texte (pour l'accessibilité)
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: Colors.orangeAccent, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.rating?.toStringAsFixed(1) ?? '0.0',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${item.totalRating})',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
