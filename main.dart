import 'package:flutter/material.dart'; /*Importa o pacote flutter/material.dart, que contém as classes e widgets necessários para construir interfaces de usuário em Flutter.*/

void main() { /*Define uma função main() como ponto de entrada do aplicativo.*/
  runApp(MyApp());  /*Define a classe MyApp, que herda de StatelessWidget. Esta classe é responsável por criar a instância do aplicativo e fornecer o widget raiz (MaterialApp) para a hierarquia de widgets.*/
}

/*Sobrescreve o método build na classe MyApp para retornar um widget MaterialApp. Esse widget define o título do aplicativo e o tema de cores, e define a página inicial como MyHomePage.*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculando MMC',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Calculando MMC'),
    );
  }
}

/*Define a classe MyHomePage, que herda de StatefulWidget. Esta classe representa a página inicial do aplicativo, onde a calculadora de MMC é exibida.*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(); /*Sobrescreve o método _MyHomePageState para criar uma instância de _MyHomePageState, que gerencia o estado da página inicial.*/
}

/*A classe _MyHomePageState define dois controladores de texto (TextEditingController) para os campos de entrada de número 1 e número 2, e uma variável result para armazenar o resultado do cálculo do MMC.*/
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  String result = '';

  @override
  void dispose() {  /*Sobrescreve o método dispose() para descartar os controladores de texto quando a página é descartada.*/
    number1Controller.dispose();
    number2Controller.dispose();
    super.dispose();
  }

  int calculateMMC(int number1, int number2) {  /*Define o método calculateMMC() para calcular o MMC de dois números inteiros.*/
    int greaterNumber = (number1 > number2) ? number1 : number2;
    while (true) {
      if (greaterNumber % number1 == 0 && greaterNumber % number2 == 0) {
        return greaterNumber;
      }
      greaterNumber++;
    }
  }

  void calculateButtonPressed() { /*Define o método calculateButtonPressed() para lidar com o evento de pressionar o botão de cálculo. Ele obtém os valores dos campos de entrada, valida os dados, calcula o MMC e atualiza o estado da página com o resultado.*/
  String number1Text = number1Controller.text.trim();
  String number2Text = number2Controller.text.trim();

  if (number1Text.isEmpty || number2Text.isEmpty) {
    setState(() {
      result = '';
    });
    return;
  }

  int number1 = int.tryParse(number1Text) ?? 0;
  int number2 = int.tryParse(number2Text) ?? 0;

  if (number1 == 0 || number2 == 0) {
    setState(() {
      result = 'Por favor, insira números diferentes de zero ou que não seja uma letra.';
    });
    return;
  }

  int mmc = calculateMMC(number1, number2);
  setState(() {
    result = 'O MMC de $number1 e $number2 é $mmc.';
  });
}

/*Sobrescreve o método build na classe _MyHomePageState para construir a interface da página. Ele retorna um widget Scaffold que contém uma barra de aplicativo (AppBar) com o título do aplicativo, um corpo (body) centralizado contendo dois campos de entrada (TextField) para os números, um botão de cálculo (ElevatedButton) e um widget de texto (Text) para exibir o resultado.*/
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/imagemmmc.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: number1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Digite o primeiro número'),
              ),
              TextField(
                controller: number2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Digite o segundo número'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: calculateButtonPressed,
                child: Text('Calcular'),
              ),
              SizedBox(height: 16.0),
              Text(
                result,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}