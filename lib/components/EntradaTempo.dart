import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/pomodor.store.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;

  final void Function()? incrementar;
  final void Function()? decrementar;

  const EntradaTempo({
    Key? key,
    required this.titulo,
    required this.valor,
    required this.incrementar,
    required this.decrementar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          this.titulo,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: decrementar,
              child: Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                primary: store.estaTrabalhando ? Colors.red : Colors.green,
              ),
            ),
            Text(
              '${this.valor} min',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: incrementar,
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                primary: store.estaTrabalhando ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
