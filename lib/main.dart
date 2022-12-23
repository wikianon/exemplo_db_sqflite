import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // referencia nossa classe single para gerenciar o banco de dados
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  // layout da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de CRUD básico'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'Inserir dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                inserir();
              },
            ),
            
            const SizedBox(
              height: 20,
            ),
            
            ElevatedButton(
              child: const Text(
                'Consultar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                consultar();
              },
            ),
            
            const SizedBox(
              height: 20,
            ),
            
            ElevatedButton(
              child: const Text(
                'Atualizar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                atualizar();
              },
            ),
            
            const SizedBox(
              height: 20,
            ),
            
            ElevatedButton(
              child: const Text(
                'Deletar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                deletar();
              },
            ),
            
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              child: const Text(
                'Deletar id',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                deletarId(1);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods
  void inserir() async {
    // linha para inserir
    Map<String, dynamic> row1 = {
      DatabaseHelper.columnNome: 'Jean',
      DatabaseHelper.columnIdade: 35
    };

    Map<String, dynamic> row2 = {
      DatabaseHelper.columnNome: 'Tereza',
      DatabaseHelper.columnIdade: 30
    };

    Map<String, dynamic> row3 = {
      DatabaseHelper.columnNome: 'Mariana',
      DatabaseHelper.columnIdade: 20
    };

    final id1 = await dbHelper.insert(row1);
    final id2 = await dbHelper.insert(row2);
    final id3 = await dbHelper.insert(row3);

    print('linha inserida id: $id1 $id2 $id3');
  }

  void consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();

    print('Consulta todas as linhas: ');

    for (var row in todasLinhas) {  
      print(row);
    }
  }

  void atualizar() async {
    // linha para atualizar
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 2,
      DatabaseHelper.columnNome: 'Maria',
      DatabaseHelper.columnIdade: 32
    };
    final linhasAfetadas = await dbHelper.update(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }

  void deletarId(int id) async {
    final linhaDeletada = await dbHelper.delete(id);
    print('linha ($linhaDeletada) deletada');
  }

  //deleta da ultima para a primeira linha.
  void deletar() async {
    // Assumindo que o numero de linhas é o id para a última linha
    int? id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id!);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
  }
}
