import 'package:flutter/material.dart';
import '../utils/colors.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(colorNavy),

      body: ListView(
        children: [

          //Header, imagem e título
          SizedBox(
            height: size.height * 0.46,
            child: Stack(children: [
                Placeholder(



                )
              ]
            ),
          ),

          //Infos basicas e botões de "Vou ir" e "Garantir ingresso"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: SizedBox(
              height: size.height * 0.30,
              child: Column(children: [
                  Placeholder(



                  )
                ]
              ),
            ),
          ),

          //Line-up com artistas (Criar uma linha com os icones de perfil dos artistas envolvidos)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
                Placeholder(
                   


                )
              ]
            ),
          ),

          //Sobre o evento (Caixa de descrições ajustavel ao tamanho da descrição)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
                Placeholder(



                )
              ]
            ),
          ),

          //Localização e link pro maps
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
                Placeholder(


                  
                )
              ]
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
