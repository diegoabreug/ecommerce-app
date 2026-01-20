import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/views/screens/tabs_screen/explore_screen/restaurant_menu_screen.dart';

class SlideCard extends StatefulWidget {
  const SlideCard({super.key});

  @override
  State<SlideCard> createState() => _SlideCardState();
}

class _SlideCardState extends State<SlideCard> {
  final Stream<QuerySnapshot> _slideCardsStream =
  FirebaseFirestore.instance.collection('slidecards').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _slideCardsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SizedBox(
          height: 350,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _slideCardContent(
                context,
                snapshot.data!.docs[index],
              );
            },
          ),
        );
      },
    );
  }
}

Widget _slideCardContent(
    BuildContext context, QueryDocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantMenuScreen(
            restaurantId: doc.id,
            restaurantName: data["slidecardTitle"],
            restaurantImage: data["slidecardImage"],
            restaurantAddress: data["slidecardAddress"],
            restaurantRating: data["rating"],
            restaurantVotes: data["votes"],
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              data['slidecardImage'],
              height: 250,
              width: 210,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 250,
                width: 210,
                color: Colors.grey,
                child: const Icon(Icons.error),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            data["slidecardTitle"],
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            data["slidecardAddress"],
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 18),
              Text(
                data["rating"].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text("(${data["votes"]} ratings)"),
              const Spacer(),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Delivery',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
