import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/views/components/header_text.dart';
import 'package:ecommerce_app/src/views/components/slide_card.dart';

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
                            text: "Discover new places",
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        //Slide Cards
                        SlideCard(),
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



//contenido de las tarjetas deslizables para el metodo _slideCards