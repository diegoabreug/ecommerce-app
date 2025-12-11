import 'package:ecommerce_app/src/views/screens/auth_screen/header_text.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        //cuadro de busqueda o filtro
                        _topBar(context),
                        //titulo principal
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.centerLeft,
                          child: HeaderText(
                            text: "Descubre Nuevos Lugares",
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        //Slide Cards
                        _slideCards(),
                        //productos populares

                      ],
                    ),
                  ),
                ]
            ),
          )
        ],
      ),
    );
  }
}

Widget _topBar(BuildContext context){
  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text("Search..."),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.12,
        child: GestureDetector(
          onTap: (){
            //movernos a la pantalla de filtros

          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade400,
            child: Icon(Icons.filter_list, color: Colors.white, size: 40),
          ),
        ),
      ),
    ],
  );
}


//tarjetas deslizables principales
Widget _slideCards(){
  return SizedBox(
    height: 350,
    child: ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return _slideCardContent(context);
      },
    ),
  );
}


//contenido de las tarjetas deslizables para el metodo _slideCards
Widget _slideCardContent(BuildContext context){
  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/delivery_images/image_card_3.jpg',
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
                child: Text("Jorge y Adela's Dinner",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Av Bolivar 1004, D.N",
                    style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                    )),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text("4.5", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                  ),
                  Text("(233 ratings)"),

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