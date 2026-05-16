import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/event_model.dart';
import '../utils/colors.dart';
//import 'package:google_fonts/google_fonts.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required EventModel event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(colorNoturno),

      body: ListView(
        children: [
          //Header, imagem e título
          //===============================================================================
          SizedBox(
            height: size.height * 0.42,
            child: Stack(
              children: [
                //Imagen ocupando todo o espaço desse SizedBox
                Positioned.fill(
                  child: Image.network(

                    //Trocar URL por variavel com imagem pega da API
                    'https://img.tribunahoje.com/E78VBhgfhxsCQoOHZfbjl-M5nLY=/840x520/smart/s3.tribunahoje.com/uploads/imagens/livinho-800x450jpg.avif',
                    fit: BoxFit.cover,
                  ),
                ),

                //Botão de voltar
                Positioned(
                  top: 20,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Color(colorDarkGrey).withOpacity(0.8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(colorBrasa),
                      ),
                    ),
                  ),
                ),

                //Botão de Compartilhar
                Positioned(
                  top: 20,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Color(colorDarkGrey).withOpacity(0.8),
                    child: IconButton(
                      onPressed: () {
                        //Ação de compartilhar
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                    ),
                  ),
                ),

                //Tipo de evemto
                Positioned(
                  left: 16,
                  bottom: 70,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(colorDarkGrey).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(colorBrasa),
                        width: 1.5,
                      ),
                    ),

                    child: Text(
                      'SHOW',
                      style: GoogleFonts.inter(
                        color: const Color(colorBrasa),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 4,

                        //possivel sombra (teste)
                        shadows: [
                          Shadow(color: Color(colorBrasa), blurRadius: 5),
                        ],
                      ),
                    ),
                  ),
                ),

                //Titulo do evento
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 5,
                  child: Text(
                    'Fazer Faltar',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,

                      //possivel sombra (teste)
                      shadows: [Shadow(color: Colors.white, blurRadius: 4)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //===============================================================================

          //Infos basicas e botões de "Vou ir" e "Garantir ingresso"
          //===============================================================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: SizedBox(
              height: size.height * 0.30,
              child: Column(
                children: [
                  
                  const SizedBox(height: 5),

                  //Caixa com infos basicas sobre o evento (trocar infos fixas por variaveis posteriormente)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: Color(colorNavy),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Row(
                      children: [
                        // DATA
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DATA & HORA',
                                style: GoogleFonts.inter(
                                  color: Color(colorGrey),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                'Sáb, 28 Mar • 17:00',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Linha central de divisoria
                        Container(width: 1, height: 40, color: Colors.white12),

                        const SizedBox(width: 20),

                        //Coluna de localização
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //Texto imutavel
                              Text(
                                'LOCALIZAÇÃO',
                                style: GoogleFonts.inter(
                                  color: Color(colorGrey),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              //Futura variavel
                              Text(
                                'Paraná Expo - Maringá, PR',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Espaçamento entre itens
                  const SizedBox(height: 16),

                  Column(

                    //Criar efeitp de confirmados e add o coração de curtida

                  ),

                  //Espaçamento entre itens
                  const SizedBox(height: 16),

                  //Botão de "VOU IR" (add função posteriormente)
                  SizedBox(
                    width: double.infinity,
                    height: 60,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(colorNavy),
                        side: BorderSide(color: Color(colorBrasa), width: 1),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {
                        //Ação
                      },

                      child: Text(
                        'VOU IR',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //Espaçamento entre itens
                  const SizedBox(height: 16),

                  //Botão de "GARANTIR INGRESSO" (add função posteriormente)
                  SizedBox(
                    width: double.infinity,
                    height: 60,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(colorBrasa),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {
                        //Ação
                      },

                      child: Text(
                        'GARANTIR INGRESSO',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //===============================================================================

          //Line-up com artistas (Criar uma linha com os icones de perfil dos artistas envolvidos)
          //===============================================================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Placeholder(
                  //add...
                )
              ]
            ),
          ),
          //===============================================================================

          //Sobre o evento (Caixa de descrições ajustavel ao tamanho da descrição)
          //===============================================================================
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Placeholder(
                  //add...
                )
              ]
            ),
          ),
          //===============================================================================

          //Localização e link pro maps
          //===============================================================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Placeholder(
                  //add...
                )
              ]
            ),
          ),
          //===============================================================================
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
