import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SlideCard extends StatefulWidget {

  const SlideCard({super.key});

  @override
  State<SlideCard> createState() => _SlideCardState();
}

class _SlideCardState extends State<SlideCard> {
  final Stream<QuerySnapshot> _slideCardsStream = FirebaseFirestore.instance.collection('slidecards').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _slideCardsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return SizedBox(
          height: 350,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return _slideCardContent(context, snapshot.data!.docs[index]);
            },
          ),
        );
      },
    );
  }
}

Widget _slideCardContent(BuildContext context, QueryDocumentSnapshot queryDocumentSnapshot){

  Map<String, dynamic> data = queryDocumentSnapshot.data() as Map<String, dynamic>;

  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            queryDocumentSnapshot['slidecardImage'],
            width: 210,
            height: 250,
            fit: BoxFit.cover,

          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(queryDocumentSnapshot["slidecardTitle"],
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(queryDocumentSnapshot["slidecardAddress"],
                    style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                    )),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(queryDocumentSnapshot["rating"],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                  Text("(${queryDocumentSnapshot["votes"]} ratings)"),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 80,
                    height: 18,
                    child: Center(
                      child: Text('Delivery', style: TextStyle(
                          fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )],
              )
            ],

          ),
        )
      ],
    ),
  );
}