import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}





class _HomeState extends State<Home> {

  final _alturacontroler = TextEditingController();
  final _pesocontroler = TextEditingController();
  String? especifica;
  String _icone = 'assets/images/inicio.png';
  String _textoexib = 'Digite as informações para calcular!';


  _calcula(double altura,double peso){
    double resultado = (peso / (altura * altura));
    return resultado;
  }

  _validanum(String altura,String peso){
    if(double.tryParse(altura) == null && double.tryParse(peso) == null){
      return false;
    }
    return true;
  }

  _especificagrau(double resulimc){

    if(resulimc<18.5){
      return 'Você está abaixo do peso!';
    }if(resulimc > 18.5 && resulimc <= 24.9){
      return 'Você está no peso ideal!';
    }if(resulimc > 25 && resulimc <= 29.9){
      return 'Você está com sobrepeso!';
    }if(resulimc > 30 && resulimc <= 39.9){
      return 'Você apresenta um grau de obesidade!';
    }if(resulimc > 39.9){
      return 'Você apresenta um grau de obesidade grave!';
    }

  }


  _especificaimagem(double resulimc){

    if(resulimc<18.5){
      return 'assets/images/abaixo.png';
    }if(resulimc > 18.5 && resulimc <= 24.9){
      return 'assets/images/normal.png';
    }if(resulimc > 25 && resulimc <= 29.9){
      return 'assets/images/sobrepeso.png';
    }if(resulimc > 30 && resulimc <= 39.9){
      return 'assets/images/obesidade.png';
    }if(resulimc > 39.9){
      return 'assets/images/grave.png';
    }

  }

  String? alturaerror;
  String? pesoerror;
  bool _campovazio(String altura, String peso){

    alturaerror = null;
    pesoerror = null;
    if(altura.isEmpty){
      alturaerror = 'O campo está vazio';
    }if(peso.isEmpty) {
      pesoerror = 'O campo está vazio';
    }
    return alturaerror == null && pesoerror == null;
  }

  _click(){
    String altura = _alturacontroler.text;
    String peso = _pesocontroler.text;
    altura = altura.replaceAll(',', '.').replaceAll(' ', '');
    peso = peso.replaceAll(',', '.').replaceAll(' ', '');
    double alt = 0;
    double pes = 0;
    double resultado;
    if(_campovazio(altura, peso)){
      if(_validanum(altura, peso)){
        alt = double.parse(altura);
        pes = double.parse(peso);
        resultado = _calcula(alt, pes);
        _textoexib = _especificagrau(resultado);
        _icone = _especificaimagem(resultado);
      }
    }else{
      _icone = 'assets/images/inicio.png';
      _textoexib = 'Alguma das informações não foi inserida!';
      setState(() {});
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(161, 249, 255, 1),
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        backgroundColor: Color.fromRGBO(27, 0, 156, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_icone,height: 280),
                SizedBox(height: 30),
                Text(_textoexib,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _alturacontroler,
                          decoration: InputDecoration(
                            suffix: Text('m'),
                            errorText: alturaerror,
                            labelText: 'Altura',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ConstrainedBox(
                        child: Container(
                          height: 45,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _pesocontroler,
                            decoration: InputDecoration(
                              suffix: Text('Kg'),
                              errorText: pesoerror,
                              labelText: 'Peso',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _click,
                        child: Text('Calcular', style: TextStyle(fontSize: 25)),
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(20, 45)),
                          backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(27, 0, 156, 1)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
